## [0.2.2] - 2022-04-02

- Update to rtl_433 master as of Mar 26, 2022 #82

## [0.2.1] - 2022-02-19

- Add builds for aarch64
- **READ BEFORE UPDATING** below still applies

## [0.2.0] - 2022-02-14

**READ BEFORE UPDATING**

The addon now uses a prebuilt image instead of being built locally when installed. This significantly speeds up installation times for slower devices, and ensures everyone is using the same code. Unfortunately, Home Assistant can't switch these installation methods automatically. To upgrade, **uninstall and reinstall the addon**. This will lose settings set in the Configuration section **but not files in `rtl_433/*.conf.template`**. Save them aside before reinstalling.

- Prevent using old cached rtl_433 repository during installation or update #43 #41
- Update to rtl_433 master as of Feb 4, 2021

## [0.1.3] - 2021-12-30

- Support multiple templated configuration files for multiple radios
  - The single-file configuration is still supported, but will be removed in a future release.
  - To migrate, create a `rtl_433` directory in your HA configuration, and move the configuration file to it, adding `.template` to the end of it.
  - The addon now also supports autodiscovery of credentials and settings for the Mosquitto HA addon. To use these settings, set your `output` line to:

```
output mqtt://${host}:${port},user=${username},pass=${password},retain=${retain}
```

- Prefix log lines with the config name
- Update rtl_433 tag pointer to latest release (to 21.12)
- Mirror Dockerfile from hertzg/rtl_433_docker

## [0.1.2] - 2021-02-10

- Update add-on config to require USB access per new supervisor config format (thanks to @telegreen and @schorsch3000)

## [0.1.1] - 2020-12-31

- Fix missing LD library path on aarch64 systems (#1, thanks @nickF007)

## [0.1.0] - 2020-12-27

- Publish the first version of the add-on
