#!/bin/bash

remaining=$(~/Library/Application\ Support/xbar/plugins/prayer-times.30s.js | head -n 1 | grep -oE '\d+:\d+')

sketchybar --set $NAME label="$remaining"
