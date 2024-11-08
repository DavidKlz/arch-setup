#!/bin/bash

install_package() {
	if yay -Q "$1" &>> /dev/null; then
		echo "$1 is already installed, skipping..."
	else
		yay -S --noconfirm "$1"
		
		if yay -Q "$1" &>> /dev/null; then
			echo "$1 installed successfully."
		else
			echo "Failed to install $1. Please try to install the package manually!"
			exit 1
		fi
	fi
}
