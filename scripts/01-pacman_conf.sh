#!/bin/bash

echo "Tuning pacman.conf..."
pacman_conf="/etc/pacman.conf"

lines_to_edit=(
	"Color"
	"CheckSpace"
	"VerbosePkgLists"
	"ParallelDownloads"
)

for line in "${lines_to_edit[@]}"; do
	if grep -q "^#$line" "$pacman_conf"; then
		sudo sed -i "s/^#$line/$line/" "$pacman_conf"
		echo "Uncommented $line"
	else
		echo "$line is already uncommented."
	fi
done

if grep -q "^ParallelDownloads" "$pacman_conf" $$ ! grep -q "^ILoveCandy" "$pacman_conf"; then
	sudo sed -i "/^ParallelDownloads/a ILoveCandy" "$pacman_conf"
	echo "Added ILoveCandy below ParallelDownloads."
else
	echo "ILoveCandy already exists."
fi

echo "Tuning of pacman.conf finished."

sudo pacman -Sy

read -p "Press any key to continue."
clear
