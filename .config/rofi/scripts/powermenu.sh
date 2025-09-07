#!/usr/bin/env bash
LC_ALL=C LANG=C; #source "$HOME"/.owl4ce_var

rofi_command="rofi -theme /home/alex/.config/rofi/themes/sidebar/own.rasi"
#rofi_command="rofi"

# Icons
shutdown="Shutdown" 
reboot="Reboot" 
lock="Lock" 
suspend="Suspend" 
logout="Logout"

echo $SEATCTL

# LoginD/ELoginD detection
if type -p "systemctl" &> /dev/null; then
    SEATCTL="systemctl"
elif type -p "loginctl" &> /dev/null; then
    SEATCTL="loginctl"
fi

# Variable passed to rofi
options=""$shutdown"\n"$reboot"\n"$lock"\n"$suspend"\n"$logout""

chosen="$(printf ${options} | $rofi_command -dmenu)"
case "$chosen" in
    "$shutdown")  systemctl poweroff
    ;;
    "$reboot")    systemctl reboot
    ;;
    "$lock")      betterlockscreen -l dim
    ;;
    "$suspend")   betterlockscreen -s #[[ "$($MUSIC_CONTROLLER status)" = *"laying"* ]] && "$MUSIC_CONTROLLER" toggle; exec "systemctl" suspend
    ;;
    "$logout")    pkill -9 -u $(whoami)
    ;;
esac

exit $?
