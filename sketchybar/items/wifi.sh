#!/bin/bash

sketchybar --add item wifi right \
  --set wifi \
  padding_left=$PADDINGS \
  icon=􀙇 \
  icon.color=$PEACH \
  script="$PLUGIN_DIR/wifi.sh" \
  --subscribe wifi wifi_change
