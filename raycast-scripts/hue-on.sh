#!/usr/bin/env bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title lights on
# @raycast.mode silent

# Optional parameters:
# @raycast.icon 💡
# @raycast.packageName Hue Utils

# Documentation:
# @raycast.description Turn office lights on
# @raycast.author AmmarCodes
# @raycast.authorURL https://raycast.com/AmmarCodes

source ~/.private_exports
ip="192.168.1.2"
group_id=82

url="https://$ip/api/$HUE_USERNAME/groups/$group_id/action"

curl -k -s -H "Accept: application/json" -X PUT --data "{\"on\": true}" $url &>/dev/null

if [[ $? != 0 ]]; then
  echo "Could not turn it on"
fi
