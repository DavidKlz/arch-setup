#!/bin/bash

hyprland_pkgs=(
	hyprland
	hyprutils
	hypridle
	hyprlock
	hyprcursor
)

script_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
parent_dir="$script_dir/.."
cd "$parent_dir" || exit 1

source "$(dirname "$(readlink -f "$0")")/functions.sh"

echo "Installing Hyprland..."

for pkg in "${hyprland_pkgs[@]}"; do
	install_package "$pkg"
	[ $? -ne 0 ] && { echo "Hyprland installation failed."; exit 1; }
done

read -p "Press any key to continue."
clear
