#!/bin/sh
sketchybar -m --add item network_up right \
  --set network_up label.font="SF Pro:Heavy:9" \
  icon.drawing=off \
  padding_right=8 \
  label.y_offset=5 \
  label.color=$WHITE \
  width=0 \
  update_freq=2 \
  background.color=$TRANSPARENT \
  script="~/.config/sketchybar/plugins/network.sh" \
  \
  --add item network_down right \
  --set network_down label.font="SF Pro:Heavy:9" \
  icon.drawing=off \
  background.color=$TRANSPARENT \
  padding_right=8 \
  label.y_offset=-5
