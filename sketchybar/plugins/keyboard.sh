#!/bin/bash

LAYOUT="$(defaults read ~/Library/Preferences/com.apple.HIToolbox.plist AppleSelectedInputSources | egrep -w 'KeyboardLayout Name' | sed -E 's/^.+ = \"?([^\"]+)\"?;$/\1/')"

case $LAYOUT in
"Arabic PC") SHORT_LAYOUT="󱌨" ;;
"U.S.") SHORT_LAYOUT="E" ;;
"Turkish-QWERTY") SHORT_LAYOUT="T" ;;
*) SHORT_LAYOUT="$LAYOUT" ;;
esac

sketchybar --set keyboard label="$SHORT_LAYOUT"
