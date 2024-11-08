#!/bin/bash

pipewire_pkgs=(
	pipewire
	wireplumber
	pipewire-audio
	pipewire-alsa
	pipewire-pulse
	sof-firmware
	pamixer
	pavucontrol
)

script_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
parent_dir="$script_dir/.."
cd "$parent_dir" || exit 1

source "$(dirname "$(readlink -f "$0")")/functions.sh"

echo "Installing Pipewire..."

for pkg in "${pipewire_pkgs[@]}"; do
	install_package "$pkg"
	[ $? -ne 0 ] && { echo "Pipewire Installation failed."; exit 1; }
done

echo "Activation Pipewire..."

systemctl --user enable --now pipewire.socket pipewire-pulse.socket wireplumber.service pipewire.service

read -p "Press any key to continue."
clear
