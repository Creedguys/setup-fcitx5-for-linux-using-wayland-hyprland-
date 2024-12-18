# Setup Fcitx5 for Linux using Wayland & Hyprland

This script automates the installation and configuration of Fcitx5 input method, including Unikey support, for systems running Wayland with Hyprland.

## Features
- Installs `fcitx5`, `fcitx5-unikey`, and additional modules for GTK and Qt support(for arch user, you don't need to do this).
- Configures environment variables for Fcitx5 to function properly.
- Automatically adds Fcitx5 to Hyprland startup configuration.

## Requirements
- Arch Linux or an Arch-based distribution
- Hyprland window manager
- `sudo` privileges to install packages

## How to Use
Do this and it will setup your fcitx(unikey-telex):
   ```bash
   git clone https://github.com/Creedguys/my_setup_fcitx5.git
   cd my_setup_fcitx5
   chmod +x setupfcitx.sh
   ./setupfcitx.sh
   cd ..
   rm -rf my_setup_fcitx5
   
