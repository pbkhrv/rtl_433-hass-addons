#!/bin/sh

if [ ! -z "$GITHUB_TOKEN" ]; then
  export GITHUB_AUTH="$GITHUB_TOKEN:x-oauth-basic@"
else
  export GITHUB_AUTH=""
fi

curl -o version.json https://${GITHUB_AUTH}api.github.com/repos/merbanan/rtl_433/git/refs/heads/master