#!/bin/bash

xdg_pkgs=(
	xdg-user-dirs
	xdg-utils
	xdg-desktop-portal-hyprland
	xdg-desktop-portal-gtk
)

script_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
parent_dir="$script_dir/.."
cd "$parent_dir" || exit 1

source "$(dirname "$(readlink -f "$0")")/functions.sh"

for pkg in "${xdg_pkgs[@]}"; do
	install_package "$pkg"
	[ $? -ne 0 ] && { echo "Failed to install XDG."; exit 1; }
done

read -p "Press any key to continue."
clear
