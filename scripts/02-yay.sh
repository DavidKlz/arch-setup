#!/bin/bash

ISAUR=$(command -v yay || command -v paru)
if [ -n "$ISAUR" ]; then
	echo "AUR helper already installed, moving on."
else
	echo "Installing yay from AUR"
	git clone https://aur.archlinux.org/yay.git || { echo "Failed to clone yay from AUR"; exit 1; }
	cd yay || { echo "Failed to open yay directory"; exit 1; }
	makepkg -si --noconfirm || { echo "Failed to install yay"; exit 1; }
	cd ..
	rm -r yay
fi

echo "Performing system update..."

yay -Syu --noconfirm || { echo "Failed to update system."; exit 1; }

read -p "Press any key to continue."
clear
