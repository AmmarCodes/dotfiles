#!/bin/bash
all_data=$(~/Library/Application\ Support/xbar/plugins/prayer-times.30s.js)
remaining=$(echo "$all_data" | head -n 1 | grep -oE '\d+:\d+')
# full_times=$(echo "$all_data" | tail -n 6 | grep -oE '.+\d+:\d+' | sed -E 's/  */: /g')

sketchybar --set $NAME label="$remaining"
