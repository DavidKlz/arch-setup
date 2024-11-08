#!/bin/bash

base=(
	base-devel
	archlinux-keyring
	linux-headers
)

echo "Installing base packages..."

for pkg in "${base[@]}"; do
	sudo pacman -S --noconfirm "$pkg"
done

read -p "Press any key to continue."
clear
