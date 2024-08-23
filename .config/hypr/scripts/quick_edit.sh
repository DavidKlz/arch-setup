#!/bin/bash
# Rofi menu for Quick Edit / View of Settings (SUPER E)

# define your preferred text editor and terminal to use
editor=${EDITOR:-nvim}
tty=kitty

configs="$HOME/.config/hypr/configs"

menu() {
  printf "1. edit ENV-variables\n"
  printf "2. edit Workspace-Rules\n"
  printf "3. edit Programms\n"
  printf "4. edit Keybinds\n"
  printf "5. edit Monitors\n"
  printf "6. edit Keyboard-Settings\n"
  printf "7. edit Theme\n"
}

main() {
  choice=$(menu | rofi -i -dmenu -theme ~/.config/rofi/launcher.rasi | cut -d. -f1)
  case $choice in
  1)
    $tty $editor "$configs/env-vars.conf"
    ;;
  2)
    $tty $editor "$configs/workspaces.conf"
    ;;
  3)
    $tty $editor "$configs/programms.conf"
    ;;
  4)
    $tty $editor "$configs/keybinds.conf"
    ;;
  5)
    $tty $editor "$configs/monitors.conf"
    ;;
  6)
    $tty $editor "$configs/input.conf"
    ;;
  7)
    $tty $editor "$configs/theme.conf"
    ;;
  esac
}

main
