# rtl_433 MQTT Auto Discovery Home Assistant Add-On

This add-on is a simple wrapper around the [rtl_433_mqtt_hass.py](https://github.com/merbanan/rtl_433/blob/a20cd1a62caa52dad97e4a99f8373b2fba3986d9/examples/rtl_433_mqtt_hass.py) script that's part of the excellent [rtl_433 project](https://github.com/merbanan/rtl_433).

Quoting the script's description:

> Publish Home Assistant MQTT auto discovery topics for rtl_433 devices.

> rtl_433_mqtt_hass.py connects to MQTT and subscribes to the rtl_433 event stream that is published to MQTT by rtl_433. The script publishes additional MQTT topics that can be used by Home Assistant to automatically discover and minimally configure new devices.

> The configuration topics published by this script tell Home Assistant what MQTT topics to subscribe to in order to receive the data published as device topics by MQTT.

For more information, see [the original script](https://github.com/merbanan/rtl_433/blob/a20cd1a62caa52dad97e4a99f8373b2fba3986d9/examples/rtl_433_mqtt_hass.py) and [Home Assistant MQTT discovery documentation](https://www.home-assistant.io/docs/mqtt/discovery/).

## What is rtl_433?

rtl_433 is a software package that reads data from radio/tv (DVB) USB dongles and decodes it. Lots of devices useful for home automation use common radio frequencies to send/receive data (temperature sensors, weather stations, motion detectors, fire/smoke detectors etc). rtl_433 allows you to receive those signals and interpret them without writing complicated signal processing code.

Quoting the [project's documentation](https://github.com/merbanan/rtl_433/blob/master/README.md):

> rtl_433 (despite the name) is a generic data receiver, mainly for the 433.92 MHz, 868 MHz (SRD), 315 MHz, 345 MHz, and 915 MHz ISM bands.

## Usage

See [DOCS.md](DOCS.md)

