## [UNRELEASED] - 2022-02-19

- Add builds for aarch64
- **READ BEFORE UPDATING** below still applies

## [0.3.0] - 2022-02-14

**READ BEFORE UPDATING**

The addon now uses a prebuilt image instead of being built locally when installed. This significantly speeds up installation times for slower devices, and ensures everyone is using the same code. Unfortunately, Home Assistant can't switch these installation methods automatically. To upgrade, **uninstall and reinstall the addon**. This will lose settings set in the Configuration section including custom-set MQTT hosts and credentials. Save them aside before reinstalling.

- Switched to using the upstream as a source for rtl_433_mqtt_hass.py #50
- Add a config option for debug (and quiet) logging #26
- Roll back protocol and path changes in 1665 patch #66

## [0.2.1] - 2021-11-20

- Fix int? needs a valid integer in config schema

## [0.2.0] - 2021-11-18

- MQTT Connection, Dockerfile, & script updates #22
  - Use local copy of rtl_433 discovery script to incorporate changes not merged upstream
  - Use add-on services connection to MQTT server
  - Add support for "force_update" flag on discovery
- Restore options for external brokers #28

## [0.1.9] - 2021-10-03

- Use local copy of rtl_433 discovery script to incorporate changes not merged upstream
- Use add-on services connection to MQTT server
- Add support for "force_update" flag on discovery

## [0.1.8] - 2021-05-24

- Add "MQTT retain" flag

## [0.1.7] - 2021-03-17

- Remove old `device_class` `"moisture"`, `"safety"` and `"depth"` from whatever devices are still using them

## [0.1.6] - 2021-02-25

- Remove `device_class` `"weather"` from whatever devices are still using it (#5)

## [0.1.5] - 2021-01-01

- Docs: explain which sensors are supported

## [0.1.4] - 2020-12-27

- Tweak documentation and icons

## [0.1.3] - 2020-12-26

- Publish the first version of the add-on
