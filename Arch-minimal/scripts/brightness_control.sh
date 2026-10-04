#!/bin/sh

backlight=/sys/class/backlight/nvidia_wmi_ec_backlight
brightness_file=$backlight/brightness
max_file=$backlight/max_brightness

current=$(cat "$brightness_file") || exit 1
max=$(cat "$max_file") || exit 1

case "$1" in
up)
	new=$((current + max / 10))
	[ "$new" -gt "$max" ] && new=$max
	;;

down)
	new=$((current - max / 10))
	[ "$new" -lt 0 ] && new=0
	;;
esac

printf '%s\n' "$new" >"$brightness_file"
