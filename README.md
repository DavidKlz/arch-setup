# Arch Hyprland Setup
## Arch Requirements
Minimal Arch Setup with base-devel and git via archinstall script.
## Installation
Clone the repo, give execute permission to the install.sh
``` Bash
git clone https://github.com/DavidKlz/arch-setup
cd arch-setup
chmod +x install.sh
./install.sh
```
### Install process
During the installation process you will be asked which packages should be installed.

**nvidia:** do you have a nvidia card build in? (y/n)
**bluetooth:** do you want to install bluetooth driver? (y/n)
**preconfigure:** should the system be preconfigured with the dotfiles from this repo? (y/n)
**theme:** if preconfiuration has been selected you can select from diffrent themes. (List of themes)
## Configuration
The installation process will create all needed folders and files inside .config to jumpstart the configuration. If the system has not been preconfigured, the configuration files contain commented-out examples.
