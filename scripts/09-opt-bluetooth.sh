#!/bin/bash

bt_pkgs=(
	bluez
	bluez-utils
	blueman
)

script_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
parent_dir="$script_dir/.."
cd "$parent_dir" || exit 1

source "$(dirname "$(readlink -f "$0")")/functions.sh"

echo "Installing bluetooth drivers..."

for pkg in "${bt_pkgs[@]}"; do
	install_package "$pkg"
	[ $? -ne 0 ] && { echo "Failed to install bluetooth drivers."; exit 1; }
done

echo "Activation bluetooth services..."
sudo systemctl enable --now bluetooth.service

read -p "Press any key to continue."
clear
