#!/bin/sh
# Battery for Arch Linux.
# Author Jonathan Sanfilippo 
# Date Mon 12 Sep 2022
# Copyright (C) 2022 Jonathan Sanfilippo <jonathansanfilippo.uk@gmail.com>
# dependencies upower

ICON="$HOME/.local/share/Battery/icon.svg"


get_Variables(){
BAT=$(upower -i $(upower -e | grep BAT) | grep -E percentage | xargs | cut -d' ' -f2|sed s/%//)
STATUS=$(upower -i $(upower -e | grep BAT) | grep -E state | xargs | cut -d' ' -f2|sed s/%//)
REF=$(echo "discharging")
}

while true; do
get_Variables

if [ "$STATUS" == "$REF" ]; then
        if [ "$BAT" -lt 5 ]; then
              notify-send -i "$ICON"  -a "Battery" "The system has been suspended based on low battery level  $BAT%" -u  critical ; 
              systemctl suspend

        elif [ "$BAT" -lt 15 ]; then
              notify-send -i "$ICON"  -a "Battery" "Battery low!  $BAT%" -u  critical ; 
              play $HOME/.local/share/Battery/audio.ogg ;
        fi
else
echo 'charging'
fi
sleep 60
get_Variables
done
