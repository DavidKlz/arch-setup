#!/bin/bash

fonts=(
	adobe-source-code-pro-fonts
	adobe-source-sans-fonts
	adobe-source-serif-fonts
	ttf-hanazono
	noto-fonts
	noto-fonts-emoji
	otf-font-awesome
	ttf-droid
	ttf-fira-code
	ttf-jetbrains-mono
	ttf-jetbrains-mono-nerd
	ttf-liberation
	ttf-dejavu
)

script_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
parent_dir="$script_dir/.."
cd "$parent_dir" || exit 1

source "$(dirname "$(readlink -f "$0")")/functions.sh"

echo "Installing fonts..."

for font in "${fonts[@]}"; do
	install_package "$font"
	[ $? -ne 0 ] && { echo "Fonts installation failed."; exit 1; }
done

read -p "Press any key to continue."
clear
