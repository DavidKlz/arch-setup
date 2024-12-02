#!/bin/bash

echo "Installing GRUB theme..."

folders=(
	gtk-3.0
	gtk-4.0
	hypr
	kitty
	qt5ct
	qt6ct
	rofi
	spicetify
	swaync
	waybar
)

git clone https://github.com/AllJavi/tartarus-grub
cd tartarus-grub
sudo cp tartarus -r /usr/share/grub/themes/
cd ..
sudo rm -r tartarus-grub

if grep -q "^#GRUB_THEME=" /etc/default/grub; then
	sudo sed -i 's/^#GRUB_THEME=".*"/GRUB_THEME=\"\/usr\/share\/grub\/themes\/tartarus\/theme.txt\"/' /etc/default/grub
fi

sudo grub-mkconfig -o /boot/grub/grub.cfg

echo "GRUB theme installed."
echo "Installing SDDM theme..."

git clone https://github.com/stepanzubkov/where-is-my-sddm-theme
cd where-is-my-sddm-theme

sudo chmod +x install.sh
sudo ./install.sh

cd ..
sudo rm -r where-is-my-sddm-theme

if [ ! -d /etc/sddm.conf.d ]; then
	sudo mkdir /etc/sddm.conf.d
fi

sudo touch /etc/sddm.conf.d/theme.conf.user
echo '[Theme]
Current=where_is_my_sddm_theme' | sudo tee -a /etc/sddm.conf.d/theme.conf.user

sudo rm "/usr/share/sddm/themes/where_is_my_sddm_theme/theme.conf"
sudo cp "$PWD/themes/theme.conf" "/usr/share/sddm/themes/where_is_my_sddm_theme/theme.conf"
echo "SDDM theme installed."
echo "Copying .config..."

for folder in "${folders[@]}"; do
	if [ -d "$HOME/.config/$folder" ]; then
		sudo rm -r "$HOME/.config/$folder"
	fi
	sudo cp -r "$PWD/.config/$folder" "$HOME/.config/"
done

sudo cp "$PWD/wallpaper/lofi-outside.mp4" "$HOME/Videos/"

sudo chown -R $(whoami):$(whoami) "$HOME/.config"
if [ -d "$HOME/.config/hypr/scripts" ]; then
	chmod +x "$HOME/.config/hypr/scripts/**"
else
	echo "Couldn't give execution rights to $HOME/.config/hypr/scripts. Please do so manually!"
fi
