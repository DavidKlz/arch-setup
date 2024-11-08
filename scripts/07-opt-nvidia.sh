#!/bin/bash

nvidia_pkgs=(
	nvidia-dkms
	nvidia-settings
	nvidia-utils
	libva
	libva-nvidia-driver-git
)

script_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
parent_dir="$script_dir/.."
cd "$parent_dir" || exit 1

source "$(dirname "$(readlink -f "$0")")/functions.sh"

echo "Installing NVIDIA-Drivers..."

for pkg in "${nvidia_pkgs[@]}"; do
	install_package "$pkg"
	[ $? -ne 0 ] && { echo "Failed to install NVIDIA-Drivers."; exit 1; }
done

if grep -qE '^MODULES=.*nvidia.*nvidia_modeset.*nvidia_uvm.*nvidia_drm' /etc/mkinitcpio.conf; then
	echo "NVIDIA modules already include in mkinitcpio.conf."
else
	sudo sed -Ei 's/^(MODULES=\([^\)]*)\)/\1 nvidia nvidia_modeset nvidia_uvm nvidia_drm)/' /etc/mkinitcpio.conf
	echo "NVIDIA modules added in mkinitcpio.conf."
fi

sudo mkinitcpio -P

NVEA="/etc/modprobe.d/nvidia.conf"
if [ -f "$NVEA" ]; then
	echo "NVIDIA options already added in your system."
else
	sudo echo -e "options nvidia_drm modeset=1 fbdev=1" | sudo tee -a "$NVEA"
	echo "NVIDIA options added to your system."
fi

GRUB="/etc/default/grub"
if [ -f "$GRUB" ]; then
	if ! sudo grep -q "nvidia-drm.modeset=1" "$GRUB"; then
		sudo sed -i -e 's/\(GRUB_CMDLINE_LINUX_DEFAULT=".*\)"/\1 nvidia-drm.modeset=1"/' "$GRUB"
		echo "NVIDIA modeset option added to GRUB."
	fi

	if ! sudo grep -q "nvidia_drm.fbdev=1" "$GRUB"; then
		sudo sed -i -e 's/\(GRUB_CMDLINE_LINUX_DEFAULT=".*\)"/\1 nvidia_drm.fbdev=1"/' "$GRUB"
		echo "NVIDIA fbdev option added to GRUB."
	fi

	sudo grub-mkconfig -o /boot/grub/grub.cfg
else
	echo "GRUB is not installed."
fi

read -p "Press any key to continue."
clear
