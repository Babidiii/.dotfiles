#!/usr/bin/env bash

# Terminate already running bar instances
killall -q polybar
# If all your bars have ipc enabled, you can also use 
# polybar-msg cmd quit

# Launch Polybar, using default config location ~/.config/polybar/config
# if type "xrandr"; then
#   for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
#     MONITOR=$m polybar babidiiiBar 2>&1 | tee -a /tmp/polybar.log & disown
#   done
# else
polybar babidiiiBar 2>&1 | tee -a /tmp/polybar.log & disown

polybar extBabidiiiBar 2>&1 | tee -a /tmp/polybar-ext.log & disown
# fi

echo "Polybar launched..."
