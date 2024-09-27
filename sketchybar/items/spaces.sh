#!/bin/bash

source "$HOME/.config/sketchybar/colors.sh" # Loads all defined colors

# FONT="JetBrainsMono Nerd Font Mono"
sketchybar --add event aerospace_workspace_change

for sid in $(aerospace list-workspaces --monitor focused); do
  clean_name=$(echo $sid | sed -e 's/..//')
  space=(
    associated_display=active
    # label="$sid"
    # icon.font="$FONT:Bold:13"
    icon.highlight_color=$WHITE
    icon.padding_left=15
    icon.padding_right=0
    icon.color=$GREEN
    padding_left=2
    padding_right=2
    icon="⏺ $clean_name"
    # label.padding_right=20
    # label.color=$GREY
    # label.highlight_color=$WHITE
    # label.font="sketchybar-app-font:Regular:16.0"
    label.y_offset=1
    icon.y_offset=1
    # background.color=$BACKGROUND_1
    # background.border_color=$BACKGROUND_2
    icon.padding_left=18
    icon.padding_right=18
    label.padding_right=33
    icon.color=$WHITE
    icon.font="$FONT:ExtraBold:14.0"
    icon.highlight_color=$GREEN
    icon.background.draw=on
    background.padding_left=-8
    background.padding_right=-8
    background.color=$BG_SEC_COLR
    background.corner_radius=$CORNER_RADIUS
    background.drawing=on
    label.drawing=off
    click_script="aerospace workspace $sid"
    script="$PLUGIN_DIR/space.sh $sid"
  )

  sketchybar --add item space.$sid left \
    --set space.$sid "${space[@]}" \
    --subscribe space.$sid aerospace_workspace_change change_windows front_app_switched

  # spaces=(
  #   background.color=$BACKGROUND_1
  #   background.border_color=$BACKGROUND_2
  #   background.border_width=2
  #   background.drawing=on
  # )
  #
  # sketchybar --add bracket spaces '/space\..*/' \
  #   --set spaces "${spaces[@]}"

  # apps=$(aerospace list-windows --workspace $sid | awk -F'|' '{gsub(/^ *| *$/, "", $2); print $2}')
  #
  # icon_strip=" "
  # if [ "${apps}" != "" ]; then
  #   while read -r app; do
  #     icon_strip+=" $($CONFIG_DIR/plugins/icon_map.sh "$app")"
  #   done <<<"${apps}"
  # else
  #   icon_strip=" —"
  # fi
  #
  # sketchybar --set space.$sid label="$icon_strip" --subscribe space.$sid aerospace_workspace_change change_windows front_app_switched
done

# for i in $(aerospace list-workspaces --monitor $m --empty); do
#   sketchybar --set space.$i display=0
# done

# for sid in $(aerospace list-workspaces --all); do
#   space=(
#     associated_display=active
#     background.color=0x44ffffff
#     background.drawing=on
#     click_script="aerospace workspace $sid"
#     icon.highlight_color=$RED
#     icon.padding_left=10
#     icon.padding_right=10
#     label.background.color=$BACKGROUND_2
#     label.background.corner_radius=9
#     label.backgrounddrawing=on
#     # label.background.height=26
#     label.drawing=on
#     label.font="sketchybar-app-font:Regular:16.0"
#     # label.padding_right=20
#     label="$sid"
#     padding_left=2
#     padding_right=2
#     script="$CONFIG_DIR/plugins/space.sh $sid"
#   )
#   sketchybar --add item space.$sid left \
#     --set space.$sid "${space[@]}" \
#     --subscribe space.$sid aerospace_workspace_change mouse.clicked
#
#   apps=$(aerospace list-windows --workspace $sid | awk -F'|' '{gsub(/^ *| *$/, "", $2); print $2}')
#
#   icon_strip=" "
#   if [ "${apps}" != "" ]; then
#     while read -r app; do
#       icon_strip+=" $($CONFIG_DIR/plugins/icon_map.sh "$app")"
#     done <<<"${apps}"
#   else
#     icon_strip=" —"
#   fi
#   sketchybar --set space.$sid label="$icon_strip"
#
# done
#
# # SPACE_ICONS=("1" "2" "3" "4" "5" "6" "7" "8" "9" "10" "11" "12" "13" "14" "15")
#
# # Destroy space on right click, focus space on left click.
# # New space by left clicking separator (>)
#
# # sid=0
# # spaces=()
# # for i in "${!SPACE_ICONS[@]}"; do
# #   sid=$(($i + 1))
# #
# #   space=(
# #     associated_space=$sid
# #     icon=${SPACE_ICONS[i]}
# #     icon.padding_left=10
# #     icon.padding_right=15
# #     padding_left=2
# #     padding_right=2
# #     label.padding_right=20
# #     icon.highlight_color=$RED
# #     label.font="sketchybar-app-font:Regular:16.0"
# #     label.background.height=26
# #     label.background.drawing=on
# #     label.background.color=$BACKGROUND_2
# #     label.background.corner_radius=8
# #     label.drawing=off
# #     script="$PLUGIN_DIR/space.sh"
# #   )
# #
# #   sketchybar --add space space.$sid left \
# #     --set space.$sid "${space[@]}" \
# #     --subscribe space.$sid mouse.clicked
# # done
# #
# spaces=(
#   background.color=$BACKGROUND_1
#   background.border_color=$BACKGROUND_2
#   background.border_width=2
#   background.drawing=on
# )
#
# sketchybar --add bracket spaces '/space\..*/' \
#   --set spaces "${spaces[@]}"
# # \
# # --add item separator left \
# # --set separator "${separator[@]}"
