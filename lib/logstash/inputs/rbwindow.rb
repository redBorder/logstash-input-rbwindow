# encoding: utf-8
require "logstash/inputs/base"
require "logstash/namespace"
require "stud/interval"
require "socket" # for Socket.gethostname
require "json" 
require 'base64'
require "rufus/scheduler"
require "dalli"
require "time"
require "yaml"

require_relative "util/location_constant"
require_relative "util/postgresql_manager"
require_relative "util/memcached_config"

# Generate a repeating message.
#
# This plugin is intented only as an example.

class LogStash::Inputs::Rbwindow < LogStash::Inputs::Base
  include LocationConstant

  config_name "rbwindow"

  # Schedule of when to periodically poll from the urls
  # Format: A hash with
  #   + key: "cron" | "every" | "in" | "at"
  #   + value: string
  # Examples:
  #   a) { "every" => "1h" }
  #   b) { "cron" => "* * * * * UTC" }
  # See: rufus/scheduler for details about different schedule options and value string format
  config :schedule, :validate => :hash, :required => true
  config :database_name,             :validate => :string, :default => "redborder",                    :required => false
  config :user,                      :validate => :string, :default => "redborder",                    :required => false
  config :password,                  :validate => :string, :default => nil,                            :required => false
  config :port,                      :validate => :number, :default => "5432",                         :required => false
  config :host,                      :validate => :string, :default => nil,                            :required => false
  config :mac_scramble_prefix,       :validate => :string, :default => nil,                            :required => false
  config :memcached_server,          :validate => :string, :default => nil,                            :required => false


  public 
  Schedule_types = %w(cron every at in)
  def register
    @dim_to_druid = [MARKET, MARKET_UUID, ORGANIZATION, ORGANIZATION_UUID,
                    DEPLOYMENT, DEPLOYMENT_UUID, SENSOR_NAME, SENSOR_UUID, 
                    NAMESPACE, SERVICE_PROVIDER, SERVICE_PROVIDER_UUID]
    @memcached_server = @memcached_server || MemcachedConfig::servers
    @memcached = Dalli::Client.new(@memcached_server, {:expires_in => 0, :value_max_bytes => 4000000})
    @postgresql_manager = PostgresqlManager.new(@memcached, @database_name, @user, @password, @port, @host, @mac_scramble_prefix)
   
    # run this postgresql update at the beggining
    @postgresql_manager.update
    @host_name = `hostname -s`.strip
    @window_time = 0
  end

  def run(queue)
    #puts "im in run of rbwindow"
    setup_schedule(queue)
  end # def run

  def setup_schedule(queue)
    #schedule hash must contain exactly one of the allowed keys
    msg_invalid_schedule = "Invalid config. schedule hash must contain " +
      "exactly one of the following keys - cron, at, every or in"
    raise Logstash::ConfigurationError, msg_invalid_schedule if @schedule.keys.length !=1
    schedule_type = @schedule.keys.first
    schedule_value = @schedule[schedule_type]
    raise LogStash::ConfigurationError, msg_invalid_schedule unless Schedule_types.include?(schedule_type)

    @scheduler = Rufus::Scheduler.new(:max_work_threads => 1)
    #as of v3.0.9, :first_in => :now doesn't work. Use the following workaround instead
    opts = schedule_type == "every" ? { :first_in => 0.01 } : {} 
    # Rbwindow Refresh 
    # Call Refresh store every 5 minutes
    @scheduler.send(schedule_type, schedule_value, opts) { run_once(queue) }

    # Clean store every day at 00:00
    @scheduler.send("cron", "00 00 * * * UTC", {}) { clean_stores }
    @scheduler.join
    
    
  end
 
  # Every day we move the current store to the historical one
  # And we clean the current one, on that way we keep the data only one day 
  def clean_stores
    @logger.info("[INFO] > Rbwindow execution: Cleaning stores..")
    # Move current store to current_store-historical and wipe current_store
    ["mobility",LOCATION_STORE,NMSP_STORE_MEASURE, NMSP_STORE_INFO, RADIUS_STORE].each do |store_name|
      current_store = @memcached.get(store_name) || {}
      @memcached.set("#{store_name}-historical",current_store)
      @memcached.set(store_name,{})
    end
  end

  def monitor_task(key)
    monitor_task = ""
    case key 
    when "rb_flow"
      monitor_task = "flowprocessor_messages"
    when "rb_location"
      monitor_task = "locationprocessor_messages"
    when "rb_nmsp"
      monitor_task = "nmspprocessor_messages"
    when "rb_monitor"
      monitor_task = "monitorprocessor_messages"
    else
       monitor_task = "enrichmentstreamtask_messages" 
    end 
    monitor_task
  end

  def make_metric(key,value)
    metric = { }
    if key and value and value != 0
      metric["type"] = "enrichmentstreamtask"
      metric["monitor"] = monitor_task(key)
      metric["timestamp"] = Time.now.to_i
      # TODO: this should be logstash and something else like the node number
      #metric["sensor_name"] = "logstash-#{@host_name}-#{key}"
      metric["sensor_name"] = "logstash-0-0-#{key}"
      metric["value"] = value
    end
    metric
  end

  # So we just need to add the code we want on this function
  def run_once(queue)
    @logger.info("[INFO] > Rbwindow execution: Refresh stores..")

    # Update the stores with database information and updateSalts for MacScrambling
    if @window_time >= 5
      @logger.info("[INFO] > Rbwindow execution: Updating postgresql info..")
      @postgresql_manager.update
      @window_time = 0
    end

    # Send message to rb_monitor with some flows counter metric
    to_reset = []

    flows_number_store = @memcached.get(FLOWS_NUMBER) || {}
    counter_store = @memcached.get(COUNTER_STORE) || {}
    counter_store.each do |key,value|
      flows_number_store[key] = value
      to_reset.push(key)
    
      metric = make_metric(key,value)     
      # send the metric as a event
      unless metric.empty? 
        e = LogStash::Event.new(metric)
        decorate(e)
        queue << e
      end
    end
    @memcached.set(FLOWS_NUMBER,flows_number_store)
    to_reset.each { |key| counter_store[key] = 0 }
    @memcached.set(COUNTER_STORE,counter_store)
 
    @window_time += 1
  end

  def stop
    # nothing to do in this case so it is not necessary to define stop
    # examples of common "stop" tasks:
    #  * close sockets (unblocking blocking reads/accepts)
    #  * cleanup temporary files
    #  * terminate spawned threads
    Stud.stop!(@interval_thread) if @interval_thread
    @scheduler.stop if @scheduler
  end
end # class LogStash::Inputs::Rbwindow
