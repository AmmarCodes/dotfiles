#!/bin/bash

FONT="JetBrainsMono Nerd Font Mono"

battery=(
  script="$PLUGIN_DIR/battery.sh"
  icon.font="$FONT:Regular:10"
  padding_left=$PADDINGS
  icon.color=$SAPPHIRE
  background.color=$BG_SEC_COLR
  update_freq=120
  updates=on
)

sketchybar --add item battery right \
  --set battery "${battery[@]}" \
  --subscribe battery power_source_change system_woke
