#!/bin/bash

SOUNDS_PATH="/System/Library/PrivateFrameworks/ScreenReader.framework/Versions/A/Resources/Sounds"
PID_FILE="/tmp/sketchybar_timer_pid"
DEFAULT_DURATION=1500
ITEM_NAME="timer" # must match the Lua item name in items/timer.lua

__start() {
  local duration="$1"

  (
    local time_left="$duration"
    while [ "$time_left" -gt 0 ]; do
      local minutes=$((time_left / 60))
      local seconds=$((time_left % 60))
      sketchybar --set "$ITEM_NAME" label="$(printf "%02d:%02d" "$minutes" "$seconds")"
      sleep 1
      time_left=$((time_left - 1))
    done

    afplay "$SOUNDS_PATH/GuideSuccess.aiff"
    sketchybar --set "$ITEM_NAME" label="Done"
  ) &
  printf "%s\n" "$!" >"$PID_FILE"
}

__stop() {
  if [ -f "$PID_FILE" ]; then
    if IFS= read -r PID <"$PID_FILE"; then
      if ps -p "$PID" >/dev/null 2>&1; then
        kill -- "$PID"
      fi
    fi
    rm -f "$PID_FILE"
  fi
}

start_countdown() {
  __stop
  __start "$1"
  afplay "$SOUNDS_PATH/TrackingOn.aiff" &
}

stop_countdown() {
  __stop
  afplay "$SOUNDS_PATH/TrackingOff.aiff" &
  sketchybar --set "$ITEM_NAME" label="No timer"
}

# Direct invocation with a duration in seconds: timer.sh 300
if [[ "$#" -eq 1 && "$1" =~ ^[0-9]+$ ]]; then
  start_countdown "$1"
  exit 0
fi

# Mouse events from SketchyBar
if [ "$SENDER" = "mouse.clicked" ]; then
  case "$BUTTON" in
  "left") start_countdown "$DEFAULT_DURATION" ;;
  "right") stop_countdown ;;
  esac
fi
