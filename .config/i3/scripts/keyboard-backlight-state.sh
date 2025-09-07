#!/bin/bash

state_file="/home/alex/.kbdbacklight"
device="tpacpi::kbd_backlight"

sleep 5

if [[ -f "$state_file" ]]
then
    # Read the last saved backlight state and the current backlight
    saved_backlight=$(cat "$state_file")
fi

# current_backlight=$(/usr/bin/brightnessctl g --device=$device)

# Apparently we gotta run this twice to get this to work properly.
# I don't care to fix this right now.
for i in $(seq 1 2);
do
    brightnessctl --device=$device set 0
    brightnessctl --device=$device set $saved_backlight
    sleep 1
done 
