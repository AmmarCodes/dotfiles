#!/bin/bash

source "$HOME/.config/sketchybar/colors.sh"

activity_data=$(curl -s "https://gitlab.com/users/aalakkad/calendar.json")
current_month=$(date +"%Y-%m")

# Get today's activity
today=$(date +"%Y-%m-%d")
activity=$(echo "$activity_data" | jq ".[\"${today}\"]")

# Initialize monthly total
total_activity=0

# Sum all activities for the current month
for day in $(echo "$activity_data" | jq -r 'keys[]'); do
  if [[ $day == $current_month* ]]; then
    day_activity=$(echo "$activity_data" | jq ".\"$day\"")
    total_activity=$((total_activity + day_activity))
  fi
done

# Set color based on today's activity
if ((activity < 5)); then
  color=$RED
elif ((activity < 20)); then
  color=$YELLOW
else
  color=$GREEN
fi

sketchybar --set $NAME label="($total_activity/$activity)" icon.color="$color"
