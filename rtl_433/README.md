# rtl_433 Home Assistant Add-on

## About

This add-on is a simple wrapper around the excellent [rtl_433](https://github.com/merbanan/rtl_433) project that receives wireless sensor data via [one of the supported SDR dongles](https://triq.org/rtl_433/HARDWARE.html), decodes and outputs it in a variety of formats including JSON and MQTT. The wireless sensors rtl_433 understands transmit data mostly on 433.92 MHz, 868 MHz, 315 MHz, 345 MHz, and 915 MHz ISM bands.

[View the rtl_433 documentation](https://triq.org/rtl_433)

## How it works

The only thing this add-on does is run rtl_433 under the Home Assistant OS supervisor. All you have to do is supply a config file.

By default, rtl_433 prints the data it receives to the terminal - it is up to you to configure it to publish the data to MQTT so that Home Assistant can access it, which can be done with one line in the config file.

Once you get the rtl_433 sensor data into MQTT, you'll need to help Home Assistant discover and make sense of it. You can do that in a number of ways:

  * manually configure `sensors` and `binary_sensors` in HA and [link them to the appropriate MQTT topics](https://www.home-assistant.io/integrations/sensor.mqtt/) coming out of rtl_433,
  * run the [rtl_433_mqtt_hass.py](https://github.com/merbanan/rtl_433/tree/master/examples/rtl_433_mqtt_hass.py) script manually or on a schedule to do most of the configuration automatically, or
  * install the [rtl_433 MQTT Auto Discovery Home Assistant Add-on](https://github.com/pbkhrv/rtl_433-hass-addons/tree/main/rtl_433_mqtt_autodiscovery), which runs rtl_433_mqtt_hass.py for you.

## Prerequisites

 To use this add-on, you need the following:

 1. [An SDR dongle supported by rtl_433](https://triq.org/rtl_433/HARDWARE.html).

 2. Home Assistant OS running on a machine with the SDR dongle plugged into it.

 3. Some wireless sensors supported by rtl_433. The full list of supported protocols and devices can be found under "Supported device protocols" section of the [rtl_433's README](https://github.com/merbanan/rtl_433/blob/master/README.md).

## Installation

 1. Create an rtl_433 config file that does what you need. It might work better if you do this on a computer other than the one running Home Assistant OS, so that you can experiment freely and iterate until you arrive at a configuration that works well. See below for more details.

 2. Upload the config file into Home Assistant's "/config" directory using whatever method works for you (via Samba add-on, ssh/scp, File Editor add-on etc).

 3. Install the add-on.

 5. Plug your SDR dongle to the machine running the add-on.

 5. Start the addon. A default configuration will be created in `/config/rtl_433/`. To add or edit additional configurations, create multiple `.conf.template` files in that directory.

 6. Start the add-on and check the logs.

## Configuration

For a "zero configuration" setup, install the [Mosquitto broker](https://github.com/home-assistant/addons/blob/master/mosquitto/DOCS.md) addon. While other brokers may work, they are not tested and will require manual setup. Once the addon is installed, start or restart the rtl_433 and rtl_433_mqtt_autodiscovery addons to start capturing known 433 MHz protocols.

For more advanced configuration, take a look at the example config file included in the rtl_433 source code: [rtl_433.example.conf](https://github.com/merbanan/rtl_433/blob/master/conf/rtl_433.example.conf)

The `retain` option controls if MQTT's `retain` flag is enabled or disabled by default. It can be overridden on a per-radio basis by setting `retain` to `true` or `false` in the `output` setting.

Assuming that you intend to get the rtl_433 data into Home Assistant, the absolute minimum that you need to specify in the config file is the [MQTT connection and authentication information](https://triq.org/rtl_433/OPERATION.html#mqtt-output):

```
output      mqtt://HOST:PORT,user=XXXX,pass=YYYYYYY
```

rtl_433 defaults to listening on 433.92MHz, but even if that's what you need, it's probably a good idea to specify the frequency explicitly to avoid confusion:

```
frequency   433.92M
```

You might also want to narrow down the list of protocols that rtl_433 should try to decode. The full list can be found under "Supported device protocols" section of the [README](https://github.com/merbanan/rtl_433/blob/master/README.md). Let's say you want to listen to Acurite 592TXR temperature/humidity sensors:

```
protocol    40
```

Last but not least, if you decide to use the MQTT auto discovery script or add-on, its documentation recommends converting units in all of the data coming out of rtl_433 into SI, and using the "newmodel" meta data format to ensure the sensor data gets into HA as accurately as possible:

```
convert     si
report_meta newmodel
```

Assuming you have only one USB dongle attached and rtl_433 is able to automatically find it, we arrive at a minimal rtl_433 config file that looks like this:

```
output      mqtt://HOST:PORT,user=XXXX,pass=YYYYYYY

frequency   433.92M
protocol    40

convert     si
report_meta newmodel
```

Please check [the official rtl_433 documentation](https://triq.org/rtl_433) and [config file examples](https://github.com/merbanan/rtl_433/tree/master/conf) for more information.

## Credit

This add-on is based on James Fry's [rtl4332mqtt Hass.IO Add-on](https://github.com/james-fry/hassio-addons/tree/master/rtl4332mqtt), which is in turn based on Chris Kacerguis' project here: [https://github.com/chriskacerguis/honeywell2mqtt](https://github.com/chriskacerguis/honeywell2mqtt), which is in turn based on Marco Verleun's rtl2mqtt image here: [https://github.com/roflmao/rtl2mqtt](https://github.com/roflmao/rtl2mqtt).
