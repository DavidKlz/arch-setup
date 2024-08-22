#!/bin/bash

colorize_prompt() {
  local color="$1"
  local message="$2"
  echo -n "${color}${message}$(tput sgr0)"
}

user_prompt() {
  if [[ ! -z "${!2}" ]]; then
    echo "$(colorize_prompt "$CAT" "$1 (Preset): ${!2}")"
    if [[ "${!2}" = [Yy] ]]; then
      return 0
    else
      return 1
    fi
  else
    eval "$2=''"
  fi
  while true; do
    read -p "$(colorize_prompt "$CAT" "$1 (y/n): ")" choice
    case "$choice" in
    [Yy]*)
      eval "$2='Y'"
      return 0
      ;;
    [Nn]*)
      eval "$2='N'"
      return 1
      ;;
    *) echo "Please answer with y or n." ;;
    esac
  done
}

user_options_prompt() {
  local prompt="$1"
  local valid_options="$2"
  local response_var="$3"

  if [[ ! -z "${!3}" ]]; then
    return 0
  else
    eval "$3=''"
  fi

  while true; do
    read -p "$(colorize_prompt "$CAT" "$prompt ($valid_options): ")" choice
    if [[ " $valid_options " == *" $choice "* ]]; then
      eval "$response_var='$choice'"
      return 0
    else
      echo "Please choose one of the provided options: $valid_options"
    fi
  done
}

echo "Hyprland Install Script"
echo

printf "\n"
user_prompt "Does your system have an nvidia gpu?" nvidia
printf "\n"
user_prompt "Do you want to install bluetooth drivers?" bluetooth
printf "\n"
user_prompt "Do you want to preconfigure Hyprland?" preconfig
printf "\n"

if [ "$preconfig" == "Y" ]; then
  user_options_prompt "Which theme do you want to install?" "gruvbox" theme
fi

execute_script() {
  local script="$1"
  local script_path="scripts/$script"
}

chmod +x scripts/*
sleep 1
echo "Starting Installation process..."

execute_script "00-base.sh"
execute_script "01-pacman_conf.sh"
execute_script "02-yay.sh"
execute_script "03-packages.sh"
execute_script "04-pipewire.sh"
execute_script "05-fonts.sh"
execute_script "06-hyprland.sh"

if [ "$nvidia" == "Y" ]; then
  execute_script "07-opt-nvidia.sh"
fi

execute_script "08-gtk_themes.sh"

if [ "$bluetooth" == "Y" ]; then
  execute_script "09-opt-bluetooth.sh"
fi

execute_script "10-thunar.sh"
execute_script "11-sddm.sh"
execute_script "12-xdhp.sh"
execute_script "13-zsh.sh"
execute_script "14-input_group.sh"

if [ "$preconfig" == "Y" ]; then
  execute_script "15-opt-configuration.sh"
fi

echo "Installation finished!"
