#!/usr/bin/env bash

WIDTH="dynamic"
HIGHLIGHT="off"
if [ "$1" = "$FOCUSED_WORKSPACE" ]; then
  WIDTH="0"
  HIGHLIGHT="on"
  # sketchybar --set $NAME icon.highlight=off
  # sketchybar --set $NAME icon.highlight=on
fi

sketchybar --animate tanh 20 --set $NAME \
  icon.highlight=$HIGHLIGHT \
  background.highlight=$HIGHLIGHT \
  label.width=$WIDTH

# mouse_clicked() {
#   if [ "$BUTTON" = "right" ]; then
#     yabai -m space --destroy $SID
#     sketchybar --trigger space_change --trigger windows_on_spaces
#   else
#     yabai -m space --focus $SID 2>/dev/null
#   fi
# }

# case "$SENDER" in
# "mouse.clicked")
#   mouse_clicked
#   ;;
# *)
# update
#   ;;
# esac
