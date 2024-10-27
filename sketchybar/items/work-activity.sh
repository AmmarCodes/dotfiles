#!/bin/bash

day_of_week=$(date +%u)

# only render in work days
if [[ "$day_of_week" -ge 1 && "$day_of_week" -le 5 ]]; then
  sketchybar --add item work-activity right \
    --set work-activity \
    icon.padding_right=0 \
    icon= \
    icon.font.size=24 \
    label= \
    label.font.size=12 \
    padding_right=$PADDINGS \
    script="$PLUGIN_DIR/work-activity.sh" \
    update_freq=3600 \
    --subscribe work-activity mouse.clicked
fi
