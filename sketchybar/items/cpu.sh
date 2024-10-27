#!/usr/bin/env sh

CPU=(
  update_freq=2
  icon.font="$FONT:Regular:22.0"
  icon=
  icon.color=$RED
  padding_right=$PADDINGS
  script="$PLUGIN_DIR/cpu.sh"
)

sketchybar --add item cpu right --set cpu "${CPU[@]}"
