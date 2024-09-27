#!/bin/bash
# source: https://github.com/ssate/dotfiles/blob/master/sketchybar/plugins/mic.sh

MIC_VOLUME=$(osascript -e 'input volume of (get volume settings)')

if [[ $MIC_VOLUME -eq 0 ]]; then
  sketchybar -m --set mic icon=
elif [[ $MIC_VOLUME -gt 0 ]]; then
  sketchybar -m --set mic icon=
fi
