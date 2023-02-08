# rtl_433 Home Assistant Add-on (next)

## About

This is the "next" version of the rtl_433 addon for Home Assistant. It includes
both unreleased changes to the addon itself, and whatever the latest
code from the rtl_433 master branch is available at build time.

When starting, rtl_433 will show the version info such as:

```
[rtl_433] rtl_433 version 22.11-89-g416d6c4f branch master at 202302071819 inputs file rtl_tcp RTL-SDR
```

To keep the same topics in MQTT when switching between the normal and next
versions of the addon, change the `output` lines in each configuration file to:

```
output mqtt://${host}:${port},user=${username},pass=${password},retain=${retain},devices=rtl_433/9b13b3f4-rtl433/devices[/type][/model][/subtype][/channel][/id],events=rtl_433/9b13b3f4-rtl433/events,states=rtl_433/9b13b3f4-rtl433/states
```

To update rtl_433 to the latest version, uninstall and reinstall the addon.
