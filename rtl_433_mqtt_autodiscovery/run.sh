#!/usr/bin/with-contenv bashio

if [ ! -z ${MQTT_HOST+x} ]; then
  echo "Running in stand-alone docker mode"
  MQTT_PORT="${MQTT_PORT:-1883}"
  RTL_TOPIC="${RTL_TOPIC:-rtl_433/+/events}"
  DISCOVERY_PREFIX="${DISCOVERY_PREFIX:-homeassistant}"
  DISCOVERY_INTERVAL="${DISCOVERY_INTERVAL:-600}"
  OTHER_ARGS="${OTHER_ARGS-}"

  LOG_LEVEL="${LOG_LEVEL-}"
  if [[ $LOG_LEVEL == "quiet" ]]; then
    OTHER_ARGS="${OTHER_ARGS} --quiet"
  fi
  if [[ $LOG_LEVEL == "debug" ]]; then
    OTHER_ARGS="${OTHER_ARGS} --debug"
  fi
else
  if bashio::services.available mqtt; then
    echo "mqtt found in this Home Assistance instance."
    MQTT_HOST=$(bashio::services mqtt "host")
    MQTT_PORT=$(bashio::services mqtt "port")
    export MQTT_USERNAME=$(bashio::services mqtt "username")
    export MQTT_PASSWORD=$(bashio::services mqtt "password")
  else
    echo "Using an external mqtt broker."
    MQTT_HOST=$(bashio::config "mqtt_host")
    MQTT_PORT=$(bashio::config "mqtt_port")
    export MQTT_USERNAME=$(bashio::config "mqtt_user")
    export MQTT_PASSWORD=$(bashio::config "mqtt_password")
  fi

  RTL_TOPIC=$(bashio::config "rtl_topic")
  DISCOVERY_PREFIX=$(bashio::config "discovery_prefix")
  DISCOVERY_INTERVAL=$(bashio::config "discovery_interval")

  OTHER_ARGS=""
  if bashio::config.true "mqtt_retain"; then
    OTHER_ARGS="${OTHER_ARGS} --retain"
  fi
  if bashio::config.true "force_update"; then
    OTHER_ARGS="${OTHER_ARGS} --force_update"
  fi
  # This is an optional parameter and we don't want to overwrite the defaults
  DEVICE_TOPIC_SUFFIX=$(bashio::config "device_topic_suffix")
  if [ ! -z $DEVICE_TOPIC_SUFFIX ]; then
    OTHER_ARGS="${OTHER_ARGS} -T ${DEVICE_TOPIC_SUFFIX}"
  fi

  LOG_LEVEL=$(bashio::config "log_level")
  if [[ $LOG_LEVEL == "quiet" ]]; then
    OTHER_ARGS="${OTHER_ARGS} --quiet"
  fi
  if [[ $LOG_LEVEL == "debug" ]]; then
    OTHER_ARGS="${OTHER_ARGS} --debug"
  fi
fi

# Set a default port for when the container is being run directly.
if [ ! -z ${MQTT_PORT+x} ]; then
  MQTT_PORT="1883"
fi

echo "Starting rtl_433_mqtt_hass.py..."
python3 -u /rtl_433_mqtt_hass.py -H $MQTT_HOST -p $MQTT_PORT -R "$RTL_TOPIC" -D "$DISCOVERY_PREFIX" -i $DISCOVERY_INTERVAL $OTHER_ARGS
