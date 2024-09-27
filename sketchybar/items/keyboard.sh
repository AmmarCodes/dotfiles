keyboard=(
  # icon.drawing=off
  icon="󰌓"
  icon.font="$FONT:Bold:28.0"
  padding_left=$PADDINGS
  script="$PLUGIN_DIR/keyboard.sh"
  icon.color=$RED
  # background.color=0xff585b70
  # background.height=20
)

sketchybar --add item keyboard right \
  --set keyboard "${keyboard[@]}" \
  --add event keyboard_change "AppleSelectedInputSourcesChangedNotification" \
  --subscribe keyboard keyboard_change
