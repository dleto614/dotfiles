#!/bin/bash

state_file="/home/alex/.kbdbacklight"
device="tpacpi::kbd_backlight"

while true
do
  if [[ -f "$state_file" ]]
  then
      # Read the last saved backlight state and the current backlight
      saved_backlight=$(cat "$state_file")
  fi

  # Check if valid saved state
  if [[ "$saved_backlight" ]]
  then
    /usr/lib/systemd/systemd-backlight save leds:tpacpi::kbd_backlight
  fi
  sleep 3
done