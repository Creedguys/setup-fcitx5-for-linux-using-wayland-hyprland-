#!/bin/bash

echo "Installing fcitx5 and unikey..."
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

echo "Setup complete! Please restart your system or logout and log back in for the changes to take effect."
