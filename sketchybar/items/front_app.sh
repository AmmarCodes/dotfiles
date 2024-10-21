#!/bin/bash

sketchybar --add item front_app left \
  --set front_app \
  label.font.style="Bold" \
  icon.font="sketchybar-app-font:Regular:16" \
  icon.padding_right=0 \
  icon.padding_left=8 \
  padding_left=26 \
  label.color=$BLUE \
  label.font.size="12" \
  icon.color=$BLUE \
  script="$PLUGIN_DIR/front_app.sh" \
  associated_display=active \
  --subscribe front_app front_app_switched # background.color=$BLUE \
