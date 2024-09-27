#!/bin/bash

zen_on() {
  sketchybar --set \
    --set apple.logo drawing=off \
    --set '/cpu.*/' drawing=off \
    --set calendar icon.drawing=off \
    --set yabai drawing=off \
    --set separator drawing=off \
    --set front_app drawing=off \
    --set volume_icon drawing=off \
    --set brew drawing=off
}

zen_off() {
  sketchybar --set \
    --set apple.logo drawing=on \
    --set '/cpu.*/' drawing=on \
    --set calendar icon.drawing=on \
    --set separator drawing=on \
    --set front_app drawing=on \
    --set yabai drawing=on \
    --set volume_icon drawing=on \
    --set brew drawing=on
}

if [ "$1" = "on" ]; then
  zen_on
elif [ "$1" = "off" ]; then
  zen_off
else
  if [ "$(sketchybar --query apple.logo | jq -r ".geometry.drawing")" = "on" ]; then
    zen_on
  else
    zen_off
  fi
fi
