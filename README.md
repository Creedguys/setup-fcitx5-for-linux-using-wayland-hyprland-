```markdown
# Setup Fcitx5 for Linux using Wayland & Hyprland

This script automates the installation and configuration of Fcitx5 input method, including Unikey support, for systems running Wayland with Hyprland. It also supports popular Linux desktop environments including GNOME, KDE, XFCE, and LXQt.

## Features
- Installs `fcitx5`, `fcitx5-unikey`, and additional modules for GTK and Qt support (for Arch users, this step is not required).
- Configures environment variables for Fcitx5 to function properly.
- Automatically adds Fcitx5 to the startup configuration for Wayland and Hyprland.
- Detects and configures your system and desktop environment (GNOME, KDE Plasma, XFCE, LXQt) to ensure Fcitx5 starts automatically.
- Supports both Arch Linux and Debian-based distributions (Ubuntu, Debian, Linux Mint, etc.).

## Requirements
- Arch Linux or an Arch-based distribution (e.g., Manjaro, EndeavourOS) or Debian-based distribution (e.g., Ubuntu, Linux Mint).
- Wayland with Hyprland window manager (or other compatible window managers).
- `sudo` privileges to install packages.

## How to Use
To set up Fcitx5 (with Unikey Telex input method), follow these steps:
```

1. Clone the repository and navigate to the directory:
   ```bash
   git clone https://github.com/Creedguys/my_setup_fcitx5.git
   cd my_setup_fcitx5
   ```

2. Make the script executable:

   ```bash
   chmod +x setupfcitx.sh
   ```

3. Run the script to install and configure Fcitx5:

   ```bash
   bash setupfcitx.sh
   ```

4. Clean up the repository:

   ```bash
   cd ..
   rm -rf my_setup_fcitx5
   ```

## What the script does
- **For Arch Linux and Arch-based distributions**:
  - Installs `fcitx5`, `fcitx5-unikey`, and other required packages using `pacman`.
  - Configures environment variables for proper Fcitx5 functionality.
  - Adds Fcitx5 to Hyprland's startup configuration (`~/.config/hypr/hyprland.conf`).
  
- **For Debian-based distributions (e.g., Ubuntu, Debian, Linux Mint)**:
  - Installs `fcitx5`, `fcitx5-unikey`, and other required packages using `apt`.
  - Configures environment variables for proper Fcitx5 functionality.
  - Ensures Fcitx5 starts automatically by adding startup commands to `~/.xprofile`.

- **Automatic Desktop Environment Configuration**:
  - Detects and configures popular Linux desktop environments (GNOME, KDE Plasma, XFCE, LXQt) to start Fcitx5 automatically when the user logs in.
  - Configures environment variables (`GTK_IM_MODULE`, `QT_IM_MODULE`, `XMODIFIERS`) in the appropriate profile files (`~/.pam_environment`, `~/.xprofile`).

## Supported Desktop Environments
- **GNOME / Ubuntu**: Automatically configures `~/.xprofile` for GNOME or Ubuntu.
- **KDE Plasma**: Automatically configures `~/.xprofile` for KDE Plasma.
- **XFCE**: Automatically configures `~/.xprofile` for XFCE.
- **LXQt**: Automatically configures `~/.xprofile` for LXQt.

## Notes
- You must restart your system or log out and log back in for the changes to take effect.
- This script is designed to work seamlessly with Wayland and the Hyprland window manager. If you're using a different window manager, you may need to adjust the script.
- The script configures Fcitx5 as the default input method across the system, including GTK and Qt applications.

## Troubleshooting
If you encounter issues with Fcitx5 not starting, make sure the following variables are set correctly:
- `GTK_IM_MODULE=fcitx5`
- `QT_IM_MODULE=fcitx5`
- `XMODIFIERS="@im=fcitx5"`

These should be added to `~/.xprofile` or `~/.pam_environment` depending on your desktop environment.

If Fcitx5 is not starting correctly in Hyprland, check the `~/.config/hypr/hyprland.conf` file to ensure `exec-once = fcitx5 &` is present.

## Contributing
Feel free to open an issue or submit a pull request if you have suggestions or improvements!

## License
This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
