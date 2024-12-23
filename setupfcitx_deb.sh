#!/bin/bash

echo "Installing fcitx5 and unikey..."
sudo apt update
sudo apt install -y fcitx5 fcitx5-unikey fcitx5-gtk fcitx5-qt fcitx5-configtool

echo "Configuring environment variables..."
if ! grep -q "fcitx5" ~/.pam_environment; then
    echo 'INPUT_METHOD=fcitx5' >> ~/.pam_environment
    echo 'GTK_IM_MODULE=fcitx5' >> ~/.pam_environment
    echo 'QT_IM_MODULE=fcitx5' >> ~/.pam_environment
    echo 'XMODIFIERS=@im=fcitx5' >> ~/.pam_environment
fi

echo "Configuring GNOME to start fcitx5..."
# Kiểm tra xem fcitx5 đã được cấu hình trong ~/.xprofile chưa
if ! grep -q "fcitx5" ~/.xprofile; then
    echo 'export GTK_IM_MODULE=fcitx5' >> ~/.xprofile
    echo 'export QT_IM_MODULE=fcitx5' >> ~/.xprofile
    echo 'export XMODIFIERS="@im=fcitx5"' >> ~/.xprofile
    echo 'fcitx5 & # Start fcitx5' >> ~/.xprofile
fi

echo "Setup complete! Please restart your system or logout and log back in for the changes to take effect."
