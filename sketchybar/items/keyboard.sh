keyboard=(
  # icon.drawing=off
  icon="󰌓"
  icon.font="$FONT:Bold:28.0"
  padding_left=$PADDINGS
  icon.color=$RED
  # background.color=0xff585b70
  # background.height=20
)

sketchybar --add item keyboard right \
  --set keyboard "${keyboard[@]}" \
  --add event keyboard_change "AppleSelectedInputSourcesChangedNotification" \
  --subscribe keyboard keyboard_change

LAYOUT="$(defaults read ~/Library/Preferences/com.apple.HIToolbox.plist AppleSelectedInputSources | egrep -w 'KeyboardLayout Name' | sed -E 's/^.+ = \"?([^\"]+)\"?;$/\1/')"

case $LAYOUT in
"Arabic PC") SHORT_LAYOUT="󱌨" ;;
"U.S.") SHORT_LAYOUT="E" ;;
"Turkish-QWERTY") SHORT_LAYOUT="T" ;;
*) SHORT_LAYOUT="$LAYOUT" ;;
esac

sketchybar --set keyboard label="$SHORT_LAYOUT"
