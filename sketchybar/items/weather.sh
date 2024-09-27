#!/bin/bash

sketchybar --add item weather right \
  --set weather \
  icon.padding_right=0 \
  icon=󰅟 \
  icon.color=$MAUVE \
  padding_right=$PADDINGS \
  script="$PLUGIN_DIR/weather.sh" \
  update_freq=3600 \
  --subscribe weather mouse.clicked
