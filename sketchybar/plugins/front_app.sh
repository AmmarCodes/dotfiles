#!/usr/bin/env bash

# having this condition will prevent having empty bar item in some cases (especially after reloading sketchybar)
if [ "$SENDER" = "front_app_switched" ]; then
  sketchybar --set $NAME label="$INFO" icon="$($HOME/.config/sketchybar/plugins/icon_map.sh "$INFO")"
fi
