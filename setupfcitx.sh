#!/bin/bash

# Phát hiện hệ điều hành
if [ -f /etc/debian_version ]; then
    OS_TYPE="debian"
elif [ -f /etc/arch-release ]; then
    OS_TYPE="arch"
else
    echo "Unsupported OS. This script only supports Arch and Debian-based distributions."
    exit 1
fi

echo "Detected $OS_TYPE. Proceeding with setup..."

# Cài đặt cho Arch Linux (hoặc Arch-based distros)
if [ "$OS_TYPE" = "arch" ]; then
    echo "Installing fcitx5 and unikey for Arch-based distributions..."
    sudo pacman -S --noconfirm fcitx5 fcitx5-unikey fcitx5-gtk fcitx5-qt fcitx5-configtool
    echo "Configuring environment variables..."
    if ! grep -q "fcitx5" ~/.pam_environment; then
        echo 'INPUT_METHOD=fcitx5' >> ~/.pam_environment
        echo 'GTK_IM_MODULE=fcitx5' >> ~/.pam_environment
        echo 'QT_IM_MODULE=fcitx5' >> ~/.pam_environment
        echo 'XMODIFIERS=@im=fcitx5' >> ~/.pam_environment
    fi
    echo "Configuring Hyprland to start fcitx5..."
    if ! grep -q "fcitx5" ~/.config/hypr/hyprland.conf; then
        echo 'exec-once = fcitx5 &' >> ~/.config/hypr/hyprland.conf
    fi
fi

# Cài đặt cho Debian-based distributions (Ubuntu, Debian, Linux Mint, v.v.)
if [ "$OS_TYPE" = "debian" ]; then
    echo "Installing fcitx5 and unikey for Debian-based distributions..."
    sudo apt update
    sudo apt install -y fcitx5 fcitx5-unikey fcitx5-gtk fcitx5-qt fcitx5-configtool
    echo "Configuring environment variables..."
    if ! grep -q "fcitx5" ~/.pam_environment; then
        echo 'INPUT_METHOD=fcitx5' >> ~/.pam_environment
        echo 'GTK_IM_MODULE=fcitx5' >> ~/.pam_environment
        echo 'QT_IM_MODULE=fcitx5' >> ~/.pam_environment
        echo 'XMODIFIERS=@im=fcitx5' >> ~/.pam_environment
    fi
    echo "Configuring GNOME (or similar desktop environment) to start fcitx5..."
    if ! grep -q "fcitx5" ~/.xprofile; then
        echo 'export GTK_IM_MODULE=fcitx5' >> ~/.xprofile
        echo 'export QT_IM_MODULE=fcitx5' >> ~/.xprofile
        echo 'export XMODIFIERS="@im=fcitx5"' >> ~/.xprofile
        echo 'fcitx5 & # Start fcitx5' >> ~/.xprofile
    fi
fi

echo "Setup complete! Please restart your system or logout and log back in for the changes to take effect."
