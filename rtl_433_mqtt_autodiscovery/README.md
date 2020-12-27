# rtl_433 MQTT Autodiscovery Home Assistant Add-On

This add-on is a simple wrapper around the [rtl_433_mqtt_hass.py](https://github.com/merbanan/rtl_433/blob/a20cd1a62caa52dad97e4a99f8373b2fba3986d9/examples/rtl_433_mqtt_hass.py) script that's part of the excellent [rtl_433 project](https://github.com/merbanan/rtl_433).

Quoting the script's description:

> Publish Home Assistant MQTT auto discovery topics for rtl_433 devices.

> rtl_433_mqtt_hass.py connects to MQTT and subscribes to the rtl_433 event stream that is published to MQTT by rtl_433. The script publishes additional MQTT topics that can be used by Home Assistant to automatically discover and minimally configure new devices.

> The configuration topics published by this script tell Home Assistant what MQTT topics to subscribe to in order to receive the data published as device topics by MQTT.

For more details, see [the original script](https://github.com/merbanan/rtl_433/blob/a20cd1a62caa52dad97e4a99f8373b2fba3986d9/examples/rtl_433_mqtt_hass.py).

## Usage

 1. Setup rtl_433 to publish device information to MQTT.

 2. Install this add-on.

 3. Configure this add-on:

  * `mqtt_host`
  * `mqtt_port`
  * `mqtt_user`
  * `mqtt_password`
  * `rtl_topic`: MQTT topic where rtl_433 is publishing its output. Default is "rtl_433".
  * `discovery_topic_prefix`: MQTT topic prefix where Home Assistant is looking for autodiscovery information. Default is "homeassistant".
  * `discovery_interval`: how often to publish autodiscovery information, in seconds. Default is 600.

 4. Start the add-on.
