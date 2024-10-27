#!/bin/bash

battery=(
  update_freq=120
  padding_right=$PADDINGS
  label.font.size="12"
  icon.color=$SAPPHIRE
  script="$PLUGIN_DIR/battery.sh"
  updates=on
)

sketchybar --add item battery right \
  --set battery "${battery[@]}" \
  --subscribe battery power_source_change system_woke
