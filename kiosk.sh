#!/bin/bash

# Run this script in display 0 (monitor)
export DISPLAY=:0

# Start x11vnc for observer to connect to debug
/usr/bin/x11vnc -create -xkb -noxrecord -noxfixes -noxdamage -display :0 -auth /var/run/lightdm/root/:0 -rfbauth /home/kiosk/.x11vnc.pass -forever -rfbport 5905 &

# If chromium crashes (usually due to rebooting), clear the crash flag so we don't have the annoying warning bar
sed -i 's/"exited_cleanly":false/"exited_cleanly":true/' /home/kiosk/.mozilla/firefox/*.default-release/prefs.js
sed -i 's/"exit_type":"Crashed"/"exit_type":"Normal"/' /home/kiosk/.mozilla/firefox/*.default-release/prefs.js

# Run chromium and open tabs
/usr/bin/firefox --kiosk http://bing.com &