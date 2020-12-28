# rtl_433 MQTT Auto Discovery Home Assistant Add-on

## About

This add-on is a simple wrapper around the [rtl_433_mqtt_hass.py](https://github.com/merbanan/rtl_433/blob/a20cd1a62caa52dad97e4a99f8373b2fba3986d9/examples/rtl_433_mqtt_hass.py) script that's part of the excellent [rtl_433] project(https://github.com/merbanan/rtl_433).

rtl_433 is a software package that receives wireless sensor data via [one of the supported SDR dongles](https://triq.org/rtl_433/HARDWARE.html), decodes and outputs it in a variety of formats including JSON and MQTT. The wireless sensors that rtl_433 understands transmit data mostly on 433.92 MHz, 868 MHz, 315 MHz, 345 MHz, and 915 MHz ISM bands.

## How it works

All the add-on does is run rtl_433_mqtt_hass.py inside the Home Assistant OS supervisor. Quoting the script's description:

> Publish Home Assistant MQTT auto discovery topics for rtl_433 devices.

> rtl_433_mqtt_hass.py connects to MQTT and subscribes to the rtl_433 event stream that is published to MQTT by rtl_433. The script publishes additional MQTT topics that can be used by Home Assistant to automatically discover and minimally configure new devices.

> The configuration topics published by this script tell Home Assistant what MQTT topics to subscribe to in order to receive the data published as device topics by MQTT.

For more information, see [the original script](https://github.com/merbanan/rtl_433/blob/a20cd1a62caa52dad97e4a99f8373b2fba3986d9/examples/rtl_433_mqtt_hass.py) and [Home Assistant MQTT discovery documentation](https://www.home-assistant.io/docs/mqtt/discovery/).

## Prerequisites

 1. rtl_433 running and publishing "events" and "device" data to MQTT. If you would like to set it up on the same machine that's running the Home Assistant OS, the simplest way might be to use the [rtl_433 Home Assistant Add-on](https://github.com/pbkhrv/rtl_433-hass-addons/tree/main/rtl_433).

## Installation

To install this Home Assistant add-on you need to add the rtl_433 add-on repository first: Navigate to the "Add-on store" tab in the Supervisor panel and enter https://github.com/pbkhrv/rtl_433-hass-addons in the "Add repository" field after selecting "Repositories" from the top-right menu. Now scroll down and select the "rtl_433 MQTT Auto Discovery" add-on.

## Configuration

  * `mqtt_host`
  * `mqtt_port`
  * `mqtt_user`
  * `mqtt_password`
  * `rtl_topic`: MQTT topic where rtl_433 is publishing its output. Default is "rtl_433".
  * `discovery_prefix`: MQTT topic prefix where Home Assistant is [looking for discovery information](https://www.home-assistant.io/docs/mqtt/discovery/#discovery_prefix). Default is "homeassistant".
  * `discovery_interval`: how often to publish discovery information, in seconds. Default is 600.

