#!/bin/bash

script_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
parent_dir="$script_dir/.."
cd "$parent_dir" || exit 1

source "$(dirname "$(readlink -f "$0")")/functions.sh"

install_package gtk-engine-murrine
if [ $? -ne 0 ]; then
	echo "Failed to install GTK engine."
	exit 1;
fi

read -p "Press any key to continue."
clear
