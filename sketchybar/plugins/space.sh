#!/usr/bin/env bash

source "$HOME/.config/sketchybar/colors.sh" # Loads all defined colors

COLOR=$BG_SEC_COLOR
TEXT=$LABEL_COLOR
if [ "$1" = "$FOCUSED_WORKSPACE" ]; then
  COLOR=$GREEN
  TEXT=$BG_SEC_COLOR
fi

sketchybar --set $NAME background.color=$COLOR label.color=$TEXT

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
