#!/bin/bash

POPUP_OFF="sketchybar --set \$NAME popup.drawing=off"
POPUP_CLICK_SCRIPT="sketchybar --set \$NAME popup.drawing=toggle popup.background.corner_radius=3"

prayers=(
  icon=""
  icon.font="$FONT:Regular:22"
  icon.padding_right=4
  icon.color=$ROSEWATER
  padding_right=$PADDINGS
  script="$PLUGIN_DIR/prayers.sh"
  update_freq=60
  click_script="$POPUP_CLICK_SCRIPT"
)

sketchybar --add item prayers right --set prayers "${prayers[@]}"
