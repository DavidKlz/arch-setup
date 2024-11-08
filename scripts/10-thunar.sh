#!/bin/bash

thunar_pkgs=(
	thunar
	thunar-volman
	tumbler
	ffmpegthumbnailer
	file-roller
	thunar-archive-plugin
)

script_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
parent_dir="$script_dir/.."
cd "$parent_dir" || exit 1

source "$(dirname "$(readlink -f "$0")")/functions.sh"

echo "Installing Thunar..."

for pkg in "${thunar_pkgs[@]}"; do
	install_package "$pkg"
	[ $? -ne 0 ] && { echo "Failed to install Thunar."; exit 1; }
done

echo "Setting up Thunar as the default file manager..."

xdg-mime default thunar.desktop inode/directory
xdg-mime default thunar.desktop application/x-wayland-gnome-saved-search

read -p "Press any key to continue."
clear
