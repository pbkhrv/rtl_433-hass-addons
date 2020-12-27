## Getting started

 1. Setup rtl_433 to publish device information to MQTT.

 2. Install this add-on.

 3. Configure this add-on:

  * `mqtt_host`
  * `mqtt_port`
  * `mqtt_user`
  * `mqtt_password`
  * `rtl_topic`: MQTT topic where rtl_433 is publishing its output. Default is "rtl_433".
  * `discovery_topic`: MQTT topic prefix where Home Assistant is [looking for discovery information](https://www.home-assistant.io/docs/mqtt/discovery/#discovery_prefix). Default is "homeassistant".
  * `discovery_interval`: how often to publish discovery information, in seconds. Default is 600.

 4. Start the add-on.

## Setting up rtl_433

You can setup rtl_433 to publish data directly to MQTT. See [rtl_433 README](https://github.com/merbanan/rtl_433/blob/master/README.md#running)

...more to come...
