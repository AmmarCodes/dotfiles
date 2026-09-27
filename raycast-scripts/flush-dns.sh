#!/usr/bin/env bash

set -e

osascript -e "do shell script \"dscacheutil -flushcache && killall -HUP mDNSResponder\" with administrator privileges"

# sudo dscacheutil -flushcache && killall -HUP mDNSResponder
