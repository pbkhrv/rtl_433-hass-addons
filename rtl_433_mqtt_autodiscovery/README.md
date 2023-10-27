# rtl_433 MQTT Auto Discovery Home Assistant Add-on

## About

This add-on is a simple wrapper around the [rtl_433_mqtt_hass.py](https://github.com/merbanan/rtl_433/blob/a20cd1a62caa52dad97e4a99f8373b2fba3986d9/examples/rtl_433_mqtt_hass.py) script that's part of the excellent [rtl_433](https://github.com/merbanan/rtl_433) project. It helps Home Assistant discover and interpret sensor data that's published to MQTT by rtl_433.

rtl_433 is a software package that receives wireless sensor data via [one of the supported SDR dongles](https://triq.org/rtl_433/HARDWARE.html), decodes and outputs it in a variety of formats including JSON and MQTT. The wireless sensors that rtl_433 understands transmit data mostly on 433.92 MHz, 868 MHz, 315 MHz, 345 MHz, and 915 MHz ISM bands.

## What sensors/devices does this script support?

The script looks for specific bits of data in rtl_433's output to figure out what kind of sensor the data is coming from and to help Home Assistant handle it appropriately.

More specifically, this script looks for the following keys in rtl_433's event data:
```
alarm
battery_ok
depth_cm
gust_speed_km_h
gust_speed_m_s
humidity
lux
moisture
noise
power_W
pressure_hPa
rain_in
rain_mm
rain_mm_h
rain_rate_in_h
rssi
snr
storm_dist
strike_count
strike_distance
tamper
temperature_1_C
temperature_2_C
temperature_C
temperature_F
uv
wind_avg_km_h
wind_avg_m_s
wind_avg_mi_h
wind_dir_deg
wind_max_m_s
wind_speed_km_h
wind_speed_m_s
```

In cases where none of the keys above appear, the script ignores the device that the event came from and doesn't notify Home Assistant about it.

### How do I check whether my sensor is supported?

One way to find out is to run rtl_433 with an SDR dongle attached on a computer other than your Home Assistant OS install, with `-F json` command line argument and check the contents of events output by rtl_433. If you don't see any of the keys mentioned above, then this script won't be able to send auto discovery information to HA for that particular sensor.

### What do I do if my sensor is not supported?

You can use one of the MQTT HA integrations to configure `binary_sensor` or `sensor` or device trigger etc manually. See [documentation](https://www.home-assistant.io/integrations/#search/mqtt) for details and search the [HA forum](https://community.home-assistant.io/search?q=mqtt%20sensor).

## How it works

All the add-on does is run rtl_433_mqtt_hass.py inside the Home Assistant OS supervisor or Docker directly. Quoting the script's description:

> Publish Home Assistant MQTT auto discovery topics for rtl_433 devices.

> rtl_433_mqtt_hass.py connects to MQTT and subscribes to the rtl_433 event stream that is published to MQTT by rtl_433. The script publishes additional MQTT topics that can be used by Home Assistant to automatically discover and minimally configure new devices.

> The configuration topics published by this script tell Home Assistant what MQTT topics to subscribe to in order to receive the data published as device topics by MQTT.

For more information, see [the original script](https://github.com/merbanan/rtl_433/blob/a20cd1a62caa52dad97e4a99f8373b2fba3986d9/examples/rtl_433_mqtt_hass.py) and [Home Assistant MQTT discovery documentation](https://www.home-assistant.io/docs/mqtt/discovery/).

## Prerequisites

This add-on doesn't do anything useful unless you already have rtl_433 running and publishing "events" and "device" data to MQTT. If you would like to set that up on the same machine that's running the Home Assistant OS, the simplest way might be to use the [rtl_433 Home Assistant Add-on](https://github.com/pbkhrv/rtl_433-hass-addons/tree/main/rtl_433).

## Home Assistant Add-on

### Installation

To install this Home Assistant add-on you need to add the rtl_433 add-on repository first:

 1. Navigate to the "Add-on store" tab in the Supervisor panel

 2. Click the menu button in the top right corner and select "Repositories"

 3. Enter https://github.com/pbkhrv/rtl_433-hass-addons in the "Add repository" field.

 4. Scroll down, select the "rtl_433 MQTT Auto Discovery" add-on and install it.

 5. It is only recommended to run the addon when trying to add a new device. Keep "Start on boot" off, enable `mqtt_retain` in the addon configuration, start the addon to register new devices, and then shut it down when done. Otherwise, `rtl_433` is likely to pick up many devices at the edge of it's range, or transient devices like tire pressure monitoring sensors (TPMS) adding many undesired devices to Home Assistant.

### Configuration

By default, this addon assumes the official Mosquitto addon is installed. In that case, the MQTT connection information is determined automatically. Otherwise, to use an external broker, provide the following configuration options:

* `mqtt_host`
* `mqtt_port`
* `mqtt_user`
* `mqtt_password`

The following options apply to all broker configurations:

* `mqtt_retain`: MQTT broker will retain configuration topics between restarts if this is set to true. Default is `false`.
* `rtl_topic`: MQTT topic where rtl_433 is publishing its output. Default is "rtl_433".
* `device_topic_suffix`: The device topic suffix, which can be helpful for keeping device topics stable if they change device ID when swapping batteries. To use this, set a devices line like `devices=rtl_433/localhost/devices[/type][/model][/subtype]/C[channel:0],events=rtl_433/localhost/events` in your rtl\_433 configuration, and then set this value to match the devices part (such as `devices[/type][/model][/subtype]/C[channel:0]`). Please keep in mind that this is a suffix - the part `rtl_433/localhost` will be taken from the MQTT event topic.
* `discovery_prefix`: MQTT topic prefix where Home Assistant is [looking for discovery information](https://www.home-assistant.io/docs/mqtt/discovery/#discovery_prefix). Default is "homeassistant".
* `discovery_interval`: how often to publish discovery information, in seconds. Default is 600.
* `force_update`: Use `force_update` flag in discovery configuration. See details [here](https://www.home-assistant.io/integrations/sensor.mqtt/#force_update).

## Stand-alone Autodiscovery in Docker

Follow these steps to run just the autodiscovery script in a dedicated container. For this setup, we recommend using the [hertzg/rtl_433_docker](https://github.com/hertzg/rtl_433_docker) images to run `rtl_433` itself.

```
docker run -e MQTT_HOST=mqtt.example.com -e MQTT_USERNAME=username -e MQTT_PASSWORD=password ghcr.io/pbkhrv/rtl_433-hass-addons-rtl_433_mqtt_autodiscovery-amd64
```

Replace `amd64` with your appropriate architecture. For Raspberry Pi, this is `armhf`, `armv7`, or `aarch64` depending on your Pi version and operating system. If unsure, running `arch` at the command line can help identify the architecture.

Using docker-compose:

```
version: '3'
services:
  rtl_433_autodiscovery:
    container_name: rtl_433_autodiscovery
    image: ghcr.io/pbkhrv/rtl_433-hass-addons-rtl_433_mqtt_autodiscovery-amd64 # On Raspberry Pi replace `amd64` with the appropriate architecture.
    environment:
      - MQTT_HOST=mqtt.example.com
      - MQTT_USERNAME=username
      - MQTT_PASSWORD=password
      # - MQTT_PORT=1883
      # - RTL_TOPIC=rtl_433/+/events
      # - DISCOVERY_PREFIX=homeassistant
      # - DISCOVERY_INTERVAL=600
      # - LOG_LEVEL=debug
      # - OTHER_ARGS=--retain
```
