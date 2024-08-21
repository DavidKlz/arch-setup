#!/bin/sh

if grep -q mirror $HOME/.config/hypr/configs/monitors.conf; then
	sed -i -e '/monitor=DP-2,2560x1440@144,auto-right,1/ s/,1,.*/,1/' $HOME/.config/hypr/configs/monitors.conf
	sed -i -e '/monitor=DP-1,2560x1440@144,auto-left,1/ s/,1,.*/,1/' $HOME/.config/hypr/configs/monitors.conf
else
	sed -i -e '/monitor=DP-1,2560x1440@144,auto-left,1/ s/,1.*/,1,mirror,DP-3/' $HOME/.config/hypr/configs/monitors.conf
	sed -i -e '/monitor=DP-2,2560x1440@144,auto-right,1/ s/,1.*/,1,mirror,DP-3/' $HOME/.config/hypr/configs/monitors.conf
fi
