#!/bin/bash

if [ -f /etc/debian_version ]; then
    OS_TYPE="debian"
elif [ -f /etc/arch-release ]; then
    OS_TYPE="arch"
else
    echo "Unsupported OS. This script only supports Arch and Debian-based distributions."
    exit 1
fi

echo "Detected $OS_TYPE. Proceeding with setup..."

configure_environment() {
    local ENV_FILE="$HOME/.pam_environment"
    local XPROFILE_FILE="$HOME/.xprofile"
    local ENV_CONFIG=("INPUT_METHOD=fcitx5" "GTK_IM_MODULE=fcitx5" "QT_IM_MODULE=fcitx5" "XMODIFIERS=@im=fcitx5")

    echo "Configuring environment variables in $ENV_FILE..."
    for config in "${ENV_CONFIG[@]}"; do
        if ! grep -q "$config" "$ENV_FILE" 2>/dev/null; then
            echo "$config" >> "$ENV_FILE"
        fi
    done

    echo "Ensuring fcitx5 starts in $XPROFILE_FILE..."
    if ! grep -q "fcitx5" "$XPROFILE_FILE" 2>/dev/null; then
        echo 'fcitx5 &' >> "$XPROFILE_FILE"
    fi
}

if [ "$OS_TYPE" = "arch" ]; then
    echo "Installing fcitx5 and unikey for Arch-based distributions..."
    sudo pacman -S --noconfirm fcitx5 fcitx5-unikey fcitx5-gtk fcitx5-qt fcitx5-configtool
elif [ "$OS_TYPE" = "debian" ]; then
    echo "Installing fcitx5 and unikey for Debian-based distributions..."
    sudo apt update
    sudo apt install -y fcitx5 fcitx5-unikey fcitx5-gtk fcitx5-qt fcitx5-configtool
fi

configure_environment

HYPRLAND_CONF="$HOME/.config/hypr/hyprland.conf"
if [ -d "$(dirname "$HYPRLAND_CONF")" ] && [ "$OS_TYPE" = "arch" ]; then
    echo "Configuring Hyprland to start fcitx5..."
    if ! grep -q "fcitx5" "$HYPRLAND_CONF" 2>/dev/null; then
        echo 'exec-once = fcitx5 &' >> "$HYPRLAND_CONF"
    fi
fi

configure_desktop_environment() {
    local DESKTOP_ENV="$1"
    local XDG_CONFIG="$HOME/.xprofile"

    echo "Detected $DESKTOP_ENV environment. Ensuring fcitx5 starts automatically..."
    if ! grep -q "fcitx5" "$XDG_CONFIG" 2>/dev/null; then
        echo 'fcitx5 &' >> "$XDG_CONFIG"
    fi
}

case "$XDG_CURRENT_DESKTOP" in
    GNOME|ubuntu) configure_desktop_environment "GNOME/Ubuntu" ;;
    KDE|Plasma) configure_desktop_environment "KDE Plasma" ;;
    XFCE) configure_desktop_environment "XFCE" ;;
    LXQt) configure_desktop_environment "LXQt" ;;
    *) echo "Desktop environment not specifically supported. Using default configuration." ;;
esac

echo "Setup complete! Please restart your system or logout and log back in for the changes to take effect."
