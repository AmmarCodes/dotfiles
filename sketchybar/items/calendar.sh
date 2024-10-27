#!/bin/bash

calendar=(
  icon.drawing=off
  update_freq=10
  background.color=$TRANSPARENT
  label.color=0xffffffff
  script="$PLUGIN_DIR/calendar.sh"
)

sketchybar --add item calendar right \
  --set calendar "${calendar[@]}" \
  --subscribe calendar system_woke
