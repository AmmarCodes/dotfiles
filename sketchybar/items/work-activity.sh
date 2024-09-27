#!/bin/bash

sketchybar --add item work-activity right \
  --set work-activity \
  icon.padding_right=0 \
  icon= \
  icon.font.size=24 \
  label= \
  padding_right=$PADDINGS \
  script="$PLUGIN_DIR/work-activity.sh" \
  update_freq=3600 \
  --subscribe work-activity mouse.clicked
