#!/bin/bash

device="tpacpi::kbd_backlight"
max=2  # max brightness level (adjust if needed)

# Path to save the backlight state
state_file="$HOME/.kbdbacklight"

current=$(brightnessctl --device=$device get)
step=$(brightnessctl --device=$device max)

# brightnessctl returns raw brightness, we want steps 0..max (usually 0..2 or 3)
# So calculate step size:
step_size=$(($step / max))

# Convert raw brightness to step index
current_step=$(($current / step_size))

# Next step: increment the saved step
next_step=$(($current_step + 1))

if [[ "$next_step" -gt "$max" ]]
then
  next_step=0
fi

# Convert back to raw brightness value
next_brightness=$((next_step * step_size))

brightnessctl --device=$device set $next_brightness

# Save current state
echo "$next_brightness" >| "$state_file"
