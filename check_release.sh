#!/bin/sh

if [ ! -z "$GITHUB_TOKEN" ]; then
  export GITHUB_AUTH="$GITHUB_TOKEN:x-oauth-basic@"
else
  export GITHUB_AUTH=""
fi

curl -o rtl_433/version.json https://${GITHUB_AUTH}api.github.com/repos/merbanan/rtl_433/git/refs/heads/master
cp rtl_433/version.json rtl_433_mqtt_autodiscovery/version.json