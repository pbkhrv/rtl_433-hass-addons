#!/usr/bin/env bashio

MQTT_HOST=$(bashio::config "mqtt_host")
MQTT_PORT=$(bashio::config "mqtt_port")
MQTT_USER=$(bashio::config "mqtt_user")
MQTT_PASS=$(bashio::config "mqtt_password")
RTL_TOPIC=$(bashio::config "rtl_topic")
DISCOVERY_PREFIX=$(bashio::config "discovery_prefix")
DISCOVERY_INTERVAL=$(bashio::config "discovery_interval")

OTHER_ARGS=""
if bashio::config.true "mqtt_retain"; then
  OTHER_ARGS="${OTHER_ARGS} --retain"
fi

echo "Starting rtl_433_mqtt_hass.py..."
python3 /rtl_433_mqtt_hass.py -d -u $MQTT_USER -P $MQTT_PASS -H $MQTT_HOST -p $MQTT_PORT -R "$RTL_TOPIC" -D "$DISCOVERY_PREFIX" -i $DISCOVERY_INTERVAL $OTHER_ARGS
