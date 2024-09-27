#!/bin/bash

source "$HOME/.config/sketchybar/colors.sh"

today=$(date +"%Y-%m-%d")
activity=$(curl -s "https://gitlab.com/users/aalakkad/calendar.json" | jq ".[\"${today}\"]")

if (($activity < 5)); then
  color=$RED
elif [[ $activity < 20 ]]; then
  color=$YELLOW
else
  color=$GREEN
fi

sketchybar --set $NAME label="$activity" icon.color="$color"
