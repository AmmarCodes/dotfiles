#!/bin/bash

sketchybar --add item prayers right \
  --set prayers \
  icon.font="$FONT:Regular:22" \
  icon.padding_right=4 \
  icon.color=$ROSEWATER \
  icon= \
  padding_right=$PADDINGS \
  script="$PLUGIN_DIR/prayers.sh" \
  update_freq=60
