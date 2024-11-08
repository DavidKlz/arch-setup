#!/bin/bash

zsh_pkgs=(
	eza
	zsh
	zsh-completions
	fzf
	oh-my-posh
)

script_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
parent_dir="$script_dir/.."
cd "$parent_dir" || exit 1

source "$(dirname "$(readlink -f "$0")")/functions.sh"

echo "Installing ZSH..."

for pkg in "${zsh_pkgs[@]}"; do
	install_package "$pkg"
	[ $? -ne 0 ] && { echo "Failed to install ZSH."; exit 1; }
done



if command -v zsh >/dev/null; then
	echo "Installing oh-my-zsh + plugins"
	if [ ! -d "$HOME/.oh-my-zsh" ]; then
		sh -c "$(wget -O- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended || true
	else
		echo "oh-my-zsh already installed."
	fi

	if [ ! -d "$HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions" ]; then
		git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions || true
	else
		echo "zsh-autosuggestions already installed."
	fi

	if [ ! -d "$HOME/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting" ]; then
		git clone https://github.com/zsh-users/zsh-syntax-highlighting ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting || true
	else
		echo "zsh-syntax-highlighting already installed."
	fi

	echo "Changing default shell to zsh..."

	while ! chsh -s $(which zsh); do
		echo "Authentication failed. Please enter the correct password."
		sleep 1
	done
fi

read -p "Press any key to continue."
clear
