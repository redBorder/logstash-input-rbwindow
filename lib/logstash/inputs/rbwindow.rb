# encoding: utf-8
require "logstash/inputs/base"
require "logstash/namespace"
require "stud/interval"
require "socket" # for Socket.gethostname
require "json" 
require 'base64'
require "rufus/scheduler"
# Generate a repeating message.
#
# This plugin is intented only as an example.

class LogStash::Inputs::Rbwindow < LogStash::Inputs::Base
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
    @memcached_server = @memcached_server || MemcachedConfig::servers.first
    @memcached = Dalli::Client.new(@memcached_server, {:expires_in => 0, :value_max_bytes => 4000000})
    @postgresql_manager = PostgresqlManager.new(@memcached, @database_name, @user, @password, @port, @host, @mac_scramble_prefix) 
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
    @scheduler.send(schedule_type, schedule_value, opts) { run_once(queue) }
    @scheduler.join
  end

  # So we just need to add the code we want on this function
  def run_once(queue)
    puts ">>>>>>>>>>>>>> Im here in rbwindow running.."
    @postgresql_manager.update
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
