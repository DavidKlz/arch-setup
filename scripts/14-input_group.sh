#!/bin/bash

if grep -q '^input:' /etc/group; then
	echo "'input' group already exists."
else
	echo "Creating 'input' group..."
	sudo groupadd input
	echo "'input' group created."
fi

sudo usermod -aG input "$(whoami)"
echo "$(whoami) added to the 'input' group."

read -p "Press any key to continue."
clear
