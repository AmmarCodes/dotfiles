#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Replace WezTerm Icon
# @raycast.mode compact

# Optional parameters:
# @raycast.icon 💻

# Documentation:
# @raycast.description Replace WezTerm icon with custom icon
# @raycast.author Stefan Imhoff
# @raycast.authorURL https://www.stefanimhoff.de

# Check if fileicon is installed
if ! command -v fileicon &>/dev/null; then
	echo "fileicon not found. Installing..."
	brew install fileicon
fi

# Replace WezTerm icon
fileicon set /Applications/WezTerm.app/ ~/.dotfiles/wezterm/terminal.icns

echo "Icon replaced!"
