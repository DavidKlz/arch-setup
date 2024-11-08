#!/bin/bash

sddm_pkgs=(
	qt6-5compat
	qt6-declarative
	sddm
)

script_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
parent_dir="$script_dir/.."
cd "$parent_dir" || exit 1

source "$(dirname "$(readlink -f "$0")")/functions.sh"

echo "Installing SDDM..."

for pkg in "${sddm_pkgs[@]}"; do
	install_package "$pkg"
	[ $? -ne 0 ] && { echo "Failed to install SDDM."; exit 1; }
done

echo "Activation SDDM..."

sudo systemctl enable sddm

sddm_conf_dir=/etc/sddm.conf.d
[ ! -d "$sddm_conf_dir" ] && { sudo mkdir "$sddm_conf_dir"; }

wayland_session_dir=/usr/share/wayland-sessions
[ ! -d "$wayland_session_dir" ] && { sudo mkdir "$wayland_session_dir"; }

read -p "Press any key to continue."
clear
