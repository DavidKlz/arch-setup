#!/bin/bash

packages=(
	aylurs-gtk-shell
	curl
	grim
	kitty
	network-manager-applet
	playerctl
	qt5ct
	qt6ct
	qt6-svg
	rofi-wayland
	slurp
	swappy
	swaync
	waybar
	swww
	wallust
	wget
	wlogout
	yad
	vim
	neovim
	mpv
	mpv-mpris
	yt-dlp
	ffmpeg
	zip
	unzip
	man-db
	man-pages
)

script_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
parent_dir="$script_dir/.."
cd "$parent_dir" || exit 1

source "$(dirname "$(readlink -f "$0")")/functions.sh"

for pkg in "${packages[@]}"; do
	install_package "$pkg"
	[ $? -ne 0 ] && { echo "Package installation failed."; exit 1; }
done

read -p "Press any key to continue."
clear
