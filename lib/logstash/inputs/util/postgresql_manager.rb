# encoding: utf-8
require "time"
require "dalli"
require "yaml"
require "pg"
require "logstash/util/loggable"
require "json"

require_relative "location_constant"

class PostgresqlManager
  include LocationConstant
  attr_accessor :enrich_columns, :wlc_sql_store, :store_sensor_sql,
                :conn, :enrich_columns, :last_update, :memcached,
                :stores_to_update, :database_name, :user, :password, :port, :host, :mac_scramble_prefix

  include LogStash::Util::Loggable

  def initialize(memcached, database_name, user, password, port, host, mac_scramble_prefix=nil)
     @memcached = memcached
     @enrich_columns = ["campus", "building", "floor", "deployment",
                           "namespace", "market", "organization", "service_provider",
                           "zone", "campus_uuid", "building_uuid", "floor_uuid",
                           "deployment_uuid", "namespace_uuid", "market_uuid", "organization_uuid",
                           "service_provider_uuid", "zone_uuid"]
     @location_psql_store = @memcached.get(LOC_PSQL_STORE) || {}
     @wlc_sql_store = @memcached.get(WLC_PSQL_STORE) || {}
     @sensor_sql_store = @memcached.get(SENSOR_PSQL_STORE) || {}
     @scrambles_store = {} # its clear everytime we update
     @mac_scramble_prefix = mac_scramble_prefix
     @stores_to_update = [WLC_PSQL_STORE, SENSOR_PSQL_STORE, LOC_PSQL_STORE]
     #@stores_to_update = [WLC_PSQL_STORE, SENSOR_PSQL_STORE]
     @database_name = database_name
     @user = user
     @password = password || get_dbpass_from_config_file
     @port = port
     @host = host || get_host_from_config_file
     @conn = nil
     @last_update = Time.now
     update(true)
  end

  def open_db
    conninfo = "host=#{@host} port=#{@port} dbname=#{@database_name} user=#{@user} password=#{@password}"
    begin
      conn = PG.connect(conninfo)
      conn.set_notice_processor do |message|
        logger.debug? && logger.debug(( description + ':' + message ))
      end
    rescue => err
      logger.error("%p during test setup: %s" % [ err.class, err.message ])
      logger.error("Error connection database.")
      logger.error(err.backtrace.join("\n"))
    end
    return conn
  end

  def get_host_from_config_file
   pass = ""
   if File.exist?("/opt/rb/var/www/rb-rails/config/database.yml")
         production_config = YAML.load_file("/opt/rb/var/www/rb-rails/config/database.yml")
         pass = production_config["production"]["host"]
   end
   return pass
  end

  def get_dbpass_from_config_file
   pass = ""
   if File.exist?("/opt/rb/var/www/rb-rails/config/database.yml")
         production_config = YAML.load_file("/opt/rb/var/www/rb-rails/config/database.yml")
         pass = production_config["production"]["password"]
   end
   return pass
  end

  def update(force = false)
    return nil unless force || need_update?
    @conn = open_db
    @wlc_sql_store = @memcached.get(WLC_PSQL_STORE) || {}
    @sensor_sql_store = @memcached.get(SENSOR_PSQL_STORE) || {}
    @stores_to_update.each { |store_name| update_store(store_name) }
    update_salts(SCRAMBLES_STORE)
    @last_update = Time.now
    @conn.finish if @conn
    return true
  end

  def need_update?
    (Time.now - @last_update) > (5*60)
  end

  def save_store(store_name)
    return @memcached.set(store_name,@scrambles_store) if store_name == SCRAMBLES_STORE
    return @memcached.set(store_name,@wlc_sql_store) if store_name == WLC_PSQL_STORE
    return @memcached.set(store_name,@location_psql_store) if store_name = LOC_PSQL_STORE
    return @memcached.set(store_name, @sensor_sql_store) if store_name == SENSOR_PSQL_STORE
  end

  def string_is_number?(param)
    true if Float(param) rescue false
  end

  def find_middle_point(coordinates)
    location = {}
    latitudes = coordinates[0].map { |point| point[0] }
    longitudes = coordinates[0].map { |point| point[1] }

    average_latitude = latitudes.inject(0.0) { |sum, el| sum + el } / latitudes.length
    average_longitude = longitudes.inject(0.0) { |sum, el| sum + el } / longitudes.length

    location["sensor_latlong"] = "%.6f," % average_latitude + "%.6f" % average_longitude

    return location
  end

  def enrich_client_latlong(latitude,longitude)
    location = {}
    if latitude && longitude && string_is_number?(latitude) && string_is_number?(longitude)
      longitude_dbl = Float((Float(longitude) * 100000) / 100000)
      latitude_dbl = Float((Float(latitude) * 100000) / 100000)
      location["client_latlong"] = "%.6f," % latitude_dbl + "%.6f" % longitude_dbl
    end
    return location
  end

  def enrich_with_columns(param)
    enriching = {}
    @enrich_columns.each { |column_name|  enriching[column_name] = param[column_name] if param[column_name] }
    return enriching
  end

  def query(store_name)
    begin
      result = @conn.exec(get_sql_query(store_name))
    rescue => e
      logger.error("SQL Exception: Error making query")
      return nil
    end
    result
  end

  def update_salts(store_name)
    @scrambles_store = {} # clear
    result = query(store_name)
    return unless result
    begin
      result.each do |row|
        #"Property" field has a json embessed
        json_content = JSON.parse(row["property"])
        # Decoding from Hexadecimal to string
        if json_content["mac_hashing_salt"]
          salt = [json_content["mac_hashing_salt"].to_s].pack('H*')
          if salt and !salt.empty?
            @scrambles_store[row["uuid"].to_s] = {}
            @scrambles_store[row["uuid"].to_s]["mac_hashing_salt"] = salt.to_s
            @scrambles_store[row["uuid"].to_s]["mac_prefix"] = @mac_prefix.to_s
          end
        end
      end
    rescue => e
      logger.error("[MacScrambling] Database:" + e.to_s)
    end
    save_store(store_name)
  end

  def update_store(store_name)
    result = query(store_name)
    return unless result
    tmpCache = Hash.new
    key = "mac_address" if store_name == WLC_PSQL_STORE
    key = "uuid" if store_name == SENSOR_PSQL_STORE or store_name == LOC_PSQL_STORE
    result.each do |rs|
      location = {}
      location.merge!rs["enrichment"] if store_name == WLC_PSQL_STORE && rs["enrichment"]
      if store_name == LOC_PSQL_STORE
        if rs["property"]
          property = JSON.parse(rs["property"])
          domain_zones = JSON.parse(property["domain_zones"]) rescue nil
          location.merge!(find_middle_point(domain_zones)) if domain_zones
        end
      else
        location.merge!(enrich_client_latlong(rs["latitude"], rs["longitude"]))
      end
      location.merge!(enrich_with_columns(rs)) if store_name == WLC_PSQL_STORE
      if rs[key] && !location.empty?
        tmpCache[rs[key]] = location
        @wlc_sql_store[rs[key]] = location if store_name == WLC_PSQL_STORE
        @sensor_sql_store[rs[key]] = location if store_name == SENSOR_PSQL_STORE
        @location_psql_store[rs[key]] = location if store_name == LOC_PSQL_STORE
      end
    end
    @wlc_sql_store.reject!{ |k,v| !tmpCache.key?k } if store_name == WLC_PSQL_STORE
    @sensor_sql_store.reject!{ |k,v| !tmpCache.key?k } if store_name == SENSOR_PSQL_STORE
    save_store(store_name)
  end

  def get_sql_query(store_name)
     return "SELECT uuid, property FROM sensors WHERE domain_type=6" if store_name == SCRAMBLES_STORE
     return "SELECT uuid, latitude, longitude FROM sensors" if store_name == SENSOR_PSQL_STORE
     return "SELECT uuid, property FROM sensors" if store_name == LOC_PSQL_STORE
     return ("SELECT DISTINCT ON (access_points.mac_address) access_points.ip_address, access_points.mac_address, access_points.enrichment," +
            " zones.name AS zone, zones.id AS zone_uuid, access_points.latitude AS latitude, access_points.longitude AS longitude, floors.name AS floor, " +
            " floors.uuid AS floor_uuid, buildings.name AS building, buildings.uuid AS building_uuid, campuses.name AS campus, campuses.uuid AS campus_uuid," +
            " deployments.name AS deployment, deployments.uuid AS deployment_uuid, namespaces.name AS namespace, namespaces.uuid AS namespace_uuid," +
            " markets.name AS market, markets.uuid AS market_uuid, organizations.name AS organization, organizations.uuid AS organization_uuid," +
            " service_providers.name AS service_provider, service_providers.uuid AS service_provider_uuid" +
            " FROM access_points JOIN sensors ON (access_points.sensor_id = sensors.id)" +
            " LEFT JOIN access_points_zones AS zones_ids ON access_points.id = zones_ids.access_point_id" +
            " LEFT JOIN zones ON zones_ids.zone_id = zones.id" +
            " LEFT JOIN (SELECT * FROM sensors WHERE domain_type=101) AS floors ON floors.lft <= sensors.lft AND floors.rgt >= sensors.rgt" +
            " LEFT JOIN (SELECT * FROM sensors WHERE domain_type=5) AS buildings ON buildings.lft <= sensors.lft AND buildings.rgt >= sensors.rgt" +
            " LEFT JOIN (SELECT * FROM sensors WHERE domain_type=4) AS campuses ON campuses.lft <= sensors.lft AND campuses.rgt >= sensors.rgt" +
            " LEFT JOIN (SELECT * FROM sensors WHERE domain_type=7) AS deployments ON deployments.lft <= sensors.lft AND deployments.rgt >= sensors.rgt" +
            " LEFT JOIN (SELECT * FROM sensors WHERE domain_type=8) AS namespaces ON namespaces.lft <= sensors.lft AND namespaces.rgt >= sensors.rgt" +
            " LEFT JOIN (SELECT * FROM sensors WHERE domain_type=3) AS markets ON markets.lft <= sensors.lft AND markets.rgt >= sensors.rgt" +
            " LEFT JOIN (SELECT * FROM sensors WHERE domain_type=2) AS organizations ON organizations.lft <= sensors.lft AND organizations.rgt >= sensors.rgt" +
            " LEFT JOIN (SELECT * FROM sensors WHERE domain_type=6) AS service_providers ON service_providers.lft <= sensors.lft AND service_providers.rgt >= sensors.rgt") if store_name == WLC_PSQL_STORE
  end # end def getSql
end
