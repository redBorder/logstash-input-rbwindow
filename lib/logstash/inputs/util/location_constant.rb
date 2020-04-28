module LocationConstant
  EVENTS_AGGREGATOR = "events" unless defined? EVENTS_AGGREGATOR
  SUM_BYTES_AGGREGATOR = "sum_bytes" unless defined? SUM_BYTES_AGGREGATOR
  SUM_PKTS_AGGREGATOR = "sum_pkts" unless defined? SUM_PKTS_AGGREGATOR
  SUM_RSSI_AGGREGATOR = "sum_rssi" unless defined? SUM_RSSI_AGGREGATOR
  SUM_DL_SCORE_AGGREGATOR = "sum_dl_score" unless defined? SUM_DL_SCORE_AGGREGATOR
  CLIENTS_AGGREGATOR = "clients" unless defined? CLIENTS_AGGREGATOR
  DWELL_AGGREGATOR = "sum_dwell_time" unless defined? DWELL_AGGREGATOR
  SESSIONS_AGGREGATOR = "sessions" unless defined? SESSIONS_AGGREGATOR
  SUM_REPETITIONS_AGGREGATOR = "sum_repetitions" unless defined? SUM_REPETITIONS_AGGREGATOR
  WIRELESS_STATIONS_AGGREGATOR = "wireless_stations" unless defined? WIRELESS_STATIONS_AGGREGATOR
  USERS_AGGREGATOR = "users" unless defined? USERS_AGGREGATOR
  SIGNATURES_AGGREGATOR = "signatures" unless defined? SIGNATURES_AGGREGATOR
  WIRELESS_CHANNELS_AGGREGATOR = "wireless_channels" unless defined? WIRELESS_CHANNELS_AGGREGATOR
  SUM_WIRELESS_TX_POWER_AGGREGATOR = "sum_wireless_tx_power" unless defined? SUM_WIRELESS_TX_POWER_AGGREGATOR
  SUM_FOLLOWERS_AGGREGATOR = "sum_followers" unless defined? SUM_FOLLOWERS_AGGREGATOR
  FILES_AGGREGATOR = "files" unless defined? FILES_AGGREGATOR
  RSSI_HISTOGRAM = "hist_rssi" unless defined? RSSI_HISTOGRAM
  DWELL_HISTOGRAM = "hist_dwell" unless defined? DWELL_HISTOGRAM
  FLOW_DATASOURCE = "rb_flow" unless defined? FLOW_DATASOURCE
  ENRICHMENT_FLOW_OUTPUT_TOPIC = "rb_flow_post" unless defined? ENRICHMENT_FLOW_OUTPUT_TOPIC
  ENRICHMENT_LOC_OUTPUT_TOPIC = "rb_location" unless defined? ENRICHMENT_LOC_OUTPUT_TOPIC
  LOCATION_POST_TOPIC = "rb_loc_post" unless defined? LOCATION_POST_TOPIC
  ENRICHMENT_APSTATE_OUTPUT_TOPIC = "rb_state_post" unless defined? ENRICHMENT_APSTATE_OUTPUT_TOPIC
  EVENT_DATASOURCE = "rb_event" unless defined? EVENT_DATASOURCE
  ENRICHMENT_EVENT_OUTPUT_TOPIC = "rb_event_post" unless defined? ENRICHMENT_EVENT_OUTPUT_TOPIC
  STATE_TOPIC = "rb_state" unless defined? STATE_TOPIC
  STATE_DATASOURCE = "rb_state" unless defined? STATE_DATASOURCE
  SOCIAL_DATASOURCE = "rb_social" unless defined? SOCIAL_DATASOURCE
  SOCIAL_TOPIC = "rb_social" unless defined? SOCIAL_TOPIC
  MONITOR_TOPIC = "rb_monitor" unless defined? MONITOR_TOPIC
  HASHTAGS_TOPIC = "rb_hashtag" unless defined? HASHTAGS_TOPIC
  HASHTAGS_DATASOURCE = "rb_hashtag" unless defined? HASHTAGS_DATASOURCE
  MALWARE_DATASOURCE = "rb_malware" unless defined? MALWARE_DATASOURCE
  MALWARE_TOPIC = "rb_malware_post" unless defined? MALWARE_TOPIC
  IOC_DATASOURCE = "rb_ioc" unless defined? IOC_DATASOURCE
  IOC_TOPIC = "rb_ioc_post" unless defined? IOC_TOPIC
  CHANGES_DATASOURCE = "rb_changes" unless defined? CHANGES_DATASOURCE
  CHANGES_TOPIC = "rb_changes" unless defined? CHANGES_TOPIC
  IOT_TOPIC = "rb_iot_post" unless defined? IOT_TOPIC
  IOT_DATASOURCE = "rb_iot" unless defined? IOT_DATASOURCE
  VAULT_TOPIC = "rb_vault_post" unless defined? VAULT_TOPIC
  VAULT_DATASOURCE = "rb_vault" unless defined? VAULT_DATASOURCE
  # Common unless defined? 
  CLIENT_MAC = "client_mac" unless defined? CLIENT_MAC
  WIRELESS_STATION = "wireless_station" unless defined? WIRELESS_STATION
  WIRELESS_ID = "wireless_id" unless defined? WIRELESS_ID
  SRC_IP = "src_ip" unless defined? SRC_IP
  SENSOR_IP = "sensor_ip" unless defined? SENSOR_IP
  DST_IP = "dst_ip" unless defined? DST_IP
  SENSOR_NAME = "sensor_name" unless defined? SENSOR_NAME
  CLIENT_LATLNG = "client_latlong" unless defined? CLIENT_LATLNG
  CLIENT_PROFILE = "client_profile" unless defined? CLIENT_PROFILE
  CLIENT_RSSI = "client_rssi" unless defined? CLIENT_RSSI
  CLIENT_RSSI_NUM = "client_rssi_num" unless defined? CLIENT_RSSI_NUM
  CLIENT_SNR = "client_snr" unless defined? CLIENT_SNR
  CLIENT_SNR_NUM = "client_snr_num" unless defined? CLIENT_SNR_NUM
  TIMESTAMP = "timestamp" unless defined? TIMESTAMP
  FIRST_SWITCHED = "first_switched" unless defined? FIRST_SWITCHED
  DURATION = "duration" unless defined? DURATION
  PKTS = "pkts" unless defined? PKTS
  BYTES = "bytes" unless defined? BYTES
  TYPE = "type" unless defined? TYPE
  SRC_VLAN = "src_vlan" unless defined? SRC_VLAN
  DST_VLAN = "dst_vlan" unless defined? DST_VLAN
  WAN_VLAN = "wan_vlan" unless defined? WAN_VLAN
  LAN_VLAN = "lan_vlan" unless defined? LAN_VLAN
  DOT11STATUS = "dot11_status" unless defined? DOT11STATUS
  CLIENT_MAC_VENDOR = "client_mac_vendor" unless defined? CLIENT_MAC_VENDOR
  CLIENT_ID = "client_id" unless defined? CLIENT_ID
  SRC_AS_NAME = "src_as_name" unless defined? SRC_AS_NAME
  SRC_AS = "src_as" unless defined? SRC_AS
  LAN_IP_AS_NAME = "lan_ip_as_name" unless defined? LAN_IP_AS_NAME
  SRC_PORT = "src_port" unless defined? SRC_PORT
  LAN_L4_PORT = "lan_l4_port" unless defined? LAN_L4_PORT
  SRC_MAP = "src_map" unless defined? SRC_MAP
  SRV_PORT = "srv_port" unless defined? SRV_PORT
  DST_AS_NAME = "dst_as_name" unless defined? DST_AS_NAME
  WAN_IP_AS_NAME = "wan_ip_as_name" unless defined? WAN_IP_AS_NAME
  DST_PORT = "dst_port" unless defined? DST_PORT
  WAN_L4_PORT = "wan_l4_port" unless defined? WAN_L4_PORT
  DST_MAP = "dst_map" unless defined? DST_MAP
  DST_AS = "dst_as" unless defined? DST_AS
  ZONE_UUID = "zone_uuid" unless defined? ZONE_UUID
  APPLICATION_ID_NAME = "application_id_name" unless defined? APPLICATION_ID_NAME
  BIFLOW_DIRECTION = "biflow_direction" unless defined? BIFLOW_DIRECTION
  CONVERSATION = "conversation" unless defined? CONVERSATION
  DIRECTION = "direction" unless defined? DIRECTION
  ENGINE_ID_NAME = "engine_id_name" unless defined? ENGINE_ID_NAME
  HTTP_HOST = "host" unless defined? HTTP_HOST
  HTTP_SOCIAL_MEDIA = "http_social_media" unless defined? HTTP_SOCIAL_MEDIA
  HTTP_SOCIAL_USER = "http_social_user" unless defined? HTTP_SOCIAL_USER
  HTTP_USER_AGENT_OS = "http_user_agent" unless defined? HTTP_USER_AGENT_OS
  HTTP_REFER_L1 = "referer" unless defined? HTTP_REFER_L1
  IP_PROTOCOL_VERSION = "ip_protocol_version" unless defined? IP_PROTOCOL_VERSION
  L4_PROTO = "l4_proto" unless defined? L4_PROTO
  LAN_IP_NET_NAME = "lan_ip_net_name" unless defined? LAN_IP_NET_NAME
  SRC_NET_NAME = "src_net_name" unless defined? SRC_NET_NAME
  WAN_IP_NET_NAME = "wan_ip_net_name" unless defined? WAN_IP_NET_NAME
  DST_NET_NAME = "dst_net_name" unless defined? DST_NET_NAME
  TOS = "tos" unless defined? TOS
  DST_COUNTRY_CODE = "dst_country_code" unless defined? DST_COUNTRY_CODE
  WAN_IP_COUNTRY_CODE = "wan_ip_country_code" unless defined? WAN_IP_COUNTRY_CODE
  SRC_COUNTRY_CODE = "src_country_code" unless defined? SRC_COUNTRY_CODE
  SRC_COUNTRY = "src_country" unless defined? SRC_COUNTRY
  DST_COUNTRY = "dst_country" unless defined? DST_COUNTRY
  LAN_IP_COUNTRY_CODE = "lan_ip_country_code" unless defined? LAN_IP_COUNTRY_CODE
  SCATTERPLOT = "scatterplot" unless defined? SCATTERPLOT
  INPUT_SNMP = "lan_interface_name" unless defined? INPUT_SNMP
  OUTPUT_SNMP = "wan_interface_name" unless defined? OUTPUT_SNMP
  INPUT_VRF = "input_vrf" unless defined? INPUT_VRF
  OUTPUT_VRF = "output_vrf" unless defined? OUTPUT_VRF
  SERVICE_PROVIDER = "service_provider" unless defined? SERVICE_PROVIDER
  SERVICE_PROVIDER_UUID = "service_provider_uuid" unless defined? SERVICE_PROVIDER_UUID
  SRC = "src" unless defined? SRC
  LAN_IP = "lan_ip" unless defined? LAN_IP
  PUBLIC_IP = "public_ip" unless defined? PUBLIC_IP
  IP_COUNTRY_CODE = "ip_country_code" unless defined? IP_COUNTRY_CODE
  IP_AS_NAME = "ip_as_name" unless defined? IP_AS_NAME
  BUILDING = "building" unless defined? BUILDING
  BUILDING_UUID = "building_uuid" unless defined? BUILDING_UUID
  CAMPUS = "campus" unless defined? CAMPUS
  CAMPUS_UUID = "campus_uuid" unless defined? CAMPUS_UUID
  FLOOR = "floor" unless defined? FLOOR
  FLOOR_UUID = "floor_uuid" unless defined? FLOOR_UUID
  ZONE = "zone" unless defined? ZONE
  COORDINATES_MAP = "coordinates_map" unless defined? COORDINATES_MAP
  HNBLOCATION = "hnblocation" unless defined? HNBLOCATION
  HNBGEOLOCATION = "hnbgeolocation" unless defined? HNBGEOLOCATION
  RAT = "rat" unless defined? RAT
  DOT11PROTOCOL = "dot11_protocol" unless defined? DOT11PROTOCOL
  DEPLOYMENT = "deployment" unless defined? DEPLOYMENT
  DEPLOYMENT_UUID = "deployment_uuid" unless defined? DEPLOYMENT_UUID
  NAMESPACE = "namespace" unless defined? NAMESPACE
  NAMESPACE_UUID = "namespace_uuid" unless defined? NAMESPACE_UUID 
  TIER = "tier" unless defined? TIER
  MSG = "msg" unless defined? MSG
  HTTPS_COMMON_NAME = "https_common_name" unless defined? HTTPS_COMMON_NAME
  TARGET_NAME = "target_name" unless defined? TARGET_NAME
  CLIENT_FULLNAME = "client_fullname" unless defined? CLIENT_FULLNAME
  PRODUCT_NAME = "product_name" unless defined? PRODUCT_NAME
  # Malware unless defined? 
  HASH_SCORE = "hash_score" unless defined? HASH_SCORE
  IP_SCORE = "ip_score" unless defined? IP_SCORE
  URL_SCORE = "url_score" unless defined? URL_SCORE
  PROBE_HASH_SCORE = "hash_probe_score" unless defined? PROBE_HASH_SCORE
  PROBE_IP_SCORE = "ip_probe_score" unless defined? PROBE_IP_SCORE
  PROBE_URL_SCORE = "url_probe_score" unless defined? PROBE_URL_SCORE
  URL = "url" unless defined? URL
  FILE_NAME = "file_name" unless defined? FILE_NAME
  EMAIL_SENDER = "email_sender" unless defined? EMAIL_SENDER
  EMAIL_DESTINATION = "email_destination" unless defined? EMAIL_DESTINATION
  EMAIL_ID = "email_id" unless defined? EMAIL_ID
  # Event unless defined? 
  ACTION = "action" unless defined? ACTION
  CLASSIFICATION = "classification" unless defined? CLASSIFICATION
  DOMAIN_NAME = "domain_name" unless defined? DOMAIN_NAME
  ETHLENGTH_RANGE = "ethlength_range" unless defined? ETHLENGTH_RANGE
  GROUP_NAME = "group_name" unless defined? GROUP_NAME
  SIG_GENERATOR = "sig_generator" unless defined? SIG_GENERATOR
  ICMPTYPE = "icmptype" unless defined? ICMPTYPE
  IPLEN_RANGE = "iplen_range" unless defined? IPLEN_RANGE
  REV = "rev" unless defined? REV
  SENSOR_UUID = "sensor_uuid" unless defined? SENSOR_UUID
  PRIORITY = "priority" unless defined? PRIORITY
  SIG_ID = "sig_id" unless defined? SIG_ID
  ETHSRC = "ethsrc" unless defined? ETHSRC
  ETHSRC_VENDOR = "ethsrc_vendor" unless defined? ETHSRC_VENDOR
  ETHDST = "ethdst" unless defined? ETHDST
  ETHDST_VENDOR = "ethdst_vendor" unless defined? ETHDST_VENDOR
  DST = "dst" unless defined? DST
  WAN_IP = "wan_ip" unless defined? WAN_IP
  TTL = "ttl" unless defined? TTL
  VLAN = "vlan" unless defined? VLAN
  MARKET = "market" unless defined? MARKET
  MARKET_UUID = "market_uuid" unless defined? MARKET_UUID
  ORGANIZATION = "organization" unless defined? ORGANIZATION
  ORGANIZATION_UUID = "organization_uuid" unless defined? ORGANIZATION_UUID
  CLIENT_LATLONG = "client_latlong" unless defined? CLIENT_LATLONG
  HASH = "hash" unless defined? HASH
  FILE_SIZE = "file_size" unless defined? FILE_SIZE
  SHA256 = "sha256" unless defined? SHA256
  FILE_URI = "file_uri" unless defined? FILE_URI
  FILE_HOSTNAME = "file_hostname" unless defined? FILE_HOSTNAME
  GROUP_UUID = "group_uuid" unless defined? GROUP_UUID
  CLIENT_NAME = "client_name" unless defined? CLIENT_NAME
  # Darklist unless defined? 
  DARKLIST_SCORE = "darklist_score" unless defined? DARKLIST_SCORE
  DARKLIST_SCORE_NAME = "darklist_score_name" unless defined? DARKLIST_SCORE_NAME
  DARKLIST_PROTOCOL = "darklist_protocol" unless defined? DARKLIST_PROTOCOL
  DARKLIST_DIRECTION = "darklist_direction" unless defined? DARKLIST_DIRECTION
  DARKLIST_CATEGORY = "darklist_category" unless defined? DARKLIST_CATEGORY
  # NMSP unless defined? 
  NMSP_AP_MAC = "ap_mac" unless defined? NMSP_AP_MAC
  NMSP_RSSI = "rssi" unless defined? NMSP_RSSI
  NMSP_DOT11STATUS = "dot11_status" unless defined? NMSP_DOT11STATUS
  NMSP_VLAN_ID = "vlan_id" unless defined? NMSP_VLAN_ID
  NMSP_DOT11PROTOCOL = "dot11_protocol" unless defined? NMSP_DOT11PROTOCOL 
  NMSP_WIRELESS_ID = "wireless_id" unless defined? NMSP_WIRELESS_ID
  # Location unless defined? 
  LOC_TIMESTAMP_MILLIS = "timestampMillis" unless defined? LOC_TIMESTAMP_MILLIS
  SSID = "ssid" unless defined? SSID
  LOC_MSEUDI = "mseUdi" unless defined? LOC_MSEUDI
  LOC_NOTIFICATIONS = "notifications" unless defined? LOC_NOTIFICATIONS
  LOC_NOTIFICATION_TYPE = "notificationType" unless defined? LOC_NOTIFICATION_TYPE
  LOC_STREAMING_NOTIFICATION = "StreamingNotification" unless defined? LOC_STREAMING_NOTIFICATION
  LOC_LOCATION = "location" unless defined? LOC_LOCATION
  LOC_GEOCOORDINATEv8 = "GeoCoordinate" unless defined? LOC_GEOCOORDINATEv8
  LOC_GEOCOORDINATEv9 = "geoCoordinate" unless defined? LOC_GEOCOORDINATEv9
  LOC_MAPINFOv8 = "MapInfo" unless defined? LOC_MAPINFOv8
  LOC_MAPINFOv9 = "mapInfo" unless defined? LOC_MAPINFOv9
  LOC_MAPCOORDINATEv8 = "MapCoordinate" unless defined? LOC_MAPCOORDINATEv8
  LOC_MACADDR = "macAddress" unless defined? LOC_MACADDR
  LOC_MAP_HIERARCHY = "mapHierarchyString" unless defined? LOC_MAP_HIERARCHY
  LOC_MAP_HIERARCHY_V10 = "locationMapHierarchy" unless defined? LOC_MAP_HIERARCHY_V10
  LOC_DOT11STATUS = "dot11Status" unless defined? LOC_DOT11STATUS
  LOC_SSID = "ssId" unless defined? LOC_SSID
  LOC_IPADDR = "ipAddress" unless defined? LOC_IPADDR
  LOC_AP_MACADDR = "apMacAddress" unless defined? LOC_AP_MACADDR
  LOC_SUBSCRIPTION_NAME = "subscriptionName" unless defined? LOC_SUBSCRIPTION_NAME
  LOC_LONGITUDE = "longitude" unless defined? LOC_LONGITUDE
  LOC_LATITUDEv8 = "latitude" unless defined? LOC_LATITUDEv8
  LOC_LATITUDEv9 = "lattitude" unless defined? LOC_LATITUDEv9
  LOC_DEVICEID = "deviceId" unless defined? LOC_DEVICEID
  LOC_BAND = "band" unless defined? LOC_BAND
  LOC_STATUS = "status" unless defined? LOC_STATUS
  LOC_USERNAME = "username" unless defined? LOC_USERNAME
  LOC_ENTITY = "entity" unless defined? LOC_ENTITY
  LOC_COORDINATE = "locationCoordinate" unless defined? LOC_COORDINATE
  LOC_COORDINATE_X = "x" unless defined? LOC_COORDINATE_X
  LOC_COORDINATE_Y = "y" unless defined? LOC_COORDINATE_Y
  LOC_COORDINATE_Z = "z" unless defined? LOC_COORDINATE_Z
  LOC_COORDINATE_UNIT = "unit" unless defined? LOC_COORDINATE_UNIT
  WIRELESS_OPERATOR = "wireless_operator" unless defined? WIRELESS_OPERATOR
  CLIENT_OS = "client_os" unless defined? CLIENT_OS
  INTERFACE_NAME = "interface_name" unless defined? INTERFACE_NAME 
  # State unless defined? 
  WIRELESS_CHANNEL = "wireless_channel" unless defined? WIRELESS_CHANNEL
  WIRELESS_TX_POWER = "wireless_tx_power" unless defined? WIRELESS_TX_POWER
  WIRELESS_ADMIN_STATE = "wireless_admin_state" unless defined? WIRELESS_ADMIN_STATE
  WIRELESS_OP_STATE = "wireless_op_state" unless defined? WIRELESS_OP_STATE
  WIRELESS_MODE = "wireless_mode" unless defined? WIRELESS_MODE
  WIRELESS_SLOT = "wireless_slot" unless defined? WIRELESS_SLOT
  WIRELESS_STATION_IP = "wireless_station_ip" unless defined? WIRELESS_STATION_IP
  STATUS = "status" unless defined? STATUS
  WIRELESS_STATION_NAME = "wireless_station_name" unless defined? WIRELESS_STATION_NAME
  #Hashtag unless defined? 
  VALUE = "value" unless defined? VALUE
  # Social unless defined? 
  USER_SCREEN_NAME = "user_screen_name" unless defined? USER_SCREEN_NAME
  USER_NAME_SOCIAL = "user_name" unless defined? USER_NAME_SOCIAL
  USER_ID = "user_id" unless defined? USER_ID
  HASHTAGS = "hashtags" unless defined? HASHTAGS
  MENTIONS = "mentions" unless defined? MENTIONS
  SENTIMENT = "sentiment" unless defined? SENTIMENT
  MSG_SEND_FROM = "msg_send_from" unless defined? MSG_SEND_FROM
  USER_FROM = "user_from" unless defined? USER_FROM
  USER_PROFILE_IMG_HTTPS = "user_profile_img_https" unless defined? USER_PROFILE_IMG_HTTPS
  INFLUENCE = "influence" unless defined? INFLUENCE
  PICTURE_URL = "picture_url" unless defined? PICTURE_URL
  LANGUAGE = "language" unless defined? LANGUAGE
  CATEGORY = "category" unless defined? CATEGORY
  FOLLOWERS = "followers" unless defined? FOLLOWERS
  #LOCATION unless defined? 
  OLD_LOC = "old" unless defined? OLD_LOC
  NEW_LOC = "new" unless defined? NEW_LOC
  DWELL_TIME = "dwell_time" unless defined? DWELL_TIME
  TRANSITION = "transition" unless defined? TRANSITION
  SESSION = "session" unless defined? SESSION
  REPETITIONS = "repetitions" unless defined? REPETITIONS
  # Radius unless defined? 
  PACKET_SRC_IP_ADDRESS = "Packet-Src-IP-Address" unless defined? PACKET_SRC_IP_ADDRESS
  USER_NAME_RADIUS = "User-Name" unless defined? USER_NAME_RADIUS
  OPERATOR_NAME = "Operator-Name" unless defined? OPERATOR_NAME
  AIRESPACE_WLAN_ID = "Airespace-Wlan_Id" unless defined? AIRESPACE_WLAN_ID
  CALLING_STATION_ID = "Calling-Station-Id" unless defined? CALLING_STATION_ID
  ACCT_STATUS_TYPE = "Acct-Status-Type" unless defined? ACCT_STATUS_TYPE
  CALLED_STATION_ID = "Called-Station-Id" unless defined? CALLED_STATION_ID
  CLIENT_ACCOUNTING_TYPE = "client_accounting_type" unless defined? CLIENT_ACCOUNTING_TYPE
  # Pms unless defined? 
  GUEST_NAME = "guest_name" unless defined? GUEST_NAME
  STAFF_NAME = "staff_name" unless defined? STAFF_NAME
  CLIENT_GENDER = "client_gender" unless defined? CLIENT_GENDER
  CLIENT_AUTH_TYPE = "client_auth_type" unless defined? CLIENT_AUTH_TYPE
  AUTH_TYPE = "auth_type" unless defined? AUTH_TYPE
  CLIENT_VIP = "client_vip" unless defined? CLIENT_VIP
  CLIENT_LOYALITY = "client_loyality" unless defined? CLIENT_LOYALITY
  #Dwell unless defined? 
  WINDOW = "window" unless defined? WINDOW
  #ICAP unless defined? 
  PROXY_IP = "proxy_ip" unless defined? PROXY_IP
  #Vault unless defined? 
  PRI = "pri" unless defined? PRI
  PRI_TEXT = "pri_text" unless defined? PRI_TEXT
  SYSLOG_FACILITY = "syslogfacility" unless defined? SYSLOG_FACILITY
  SYSLOG_FACILITY_TEXT = "syslogfacility_text" unless defined? SYSLOG_FACILITY_TEXT
  SYSLOGSEVERITY = "syslogseverity" unless defined? SYSLOGSEVERITY
  SYSLOGSEVERITY_TEXT = "syslogseverity_text" unless defined? SYSLOGSEVERITY_TEXT
  HOSTNAME = "hostname" unless defined? HOSTNAME
  FROMHOST_IP = "fromhost_ip" unless defined? FROMHOST_IP
  APP_NAME = "app_name" unless defined? APP_NAME
  PROXY_UUID = "proxy_uuid" unless defined? PROXY_UUID
  MESSAGE = "message" unless defined? MESSAGE
  SOURCE = "source" unless defined? SOURCE
  TARGET = "target" unless defined? TARGET
  #NMSP unless defined? 
  NMSP_TYPE_MEASURE = "measure" unless defined? NMSP_TYPE_MEASURE
  NMSP_TYPE_INFO = "info" unless defined? NMSP_TYPE_INFO
  #LOC unless defined? 
  LOC_ASSOCIATED = "ASSOCIATED" unless defined? LOC_ASSOCIATED
  LOC_PROBING = "PROBING" unless defined? LOC_PROBING
  WLC_PSQL_STORE="wlc-psql" unless defined? WLC_PSQL_STORE
  SCRAMBLES_STORE="scrambles" unless defined? SCRAMBLES_STORE
  SENSOR_PSQL_STORE="sensor-psql" unless defined? SENSOR_PSQL_STORE
  NMSP_STORE_MEASURE = "nmsp-measure" unless defined? NMSP_STORE_MEASURE
  NMSP_STORE_INFO = "nmsp-info" unless defined? NMSP_STORE_INFO
  RADIUS_STORE = "radius" unless defined? RADIUS_STORE
  DWELL_STORE = "dwell" unless defined? DWELL_STORE
  COUNTER_STORE="counterStore" unless defined? COUNTER_STORE
  FLOWS_NUMBER="flowsNumber" unless defined? FLOWS_NUMBER
  LOCATION_STORE="location" unless defined? LOCATION_STORE
end
