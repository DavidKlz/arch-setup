#!/bin/sh

if pidof "waybar" >/dev/null; then
	pkill "waybar"
fi
sleep 2
waybar &
exit 0
