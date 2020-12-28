#!/usr/bin/env bashio

CONF_FILE=$(bashio::config "rtl_433_conf_file")
CONF_FILE="/config/$CONF_FILE"

echo "Starting rtl_433 -c $CONF_FILE"
rtl_433 -c "$CONF_FILE"
