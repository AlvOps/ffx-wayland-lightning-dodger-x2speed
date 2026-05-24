#!/usr/bin/env bash
# FFX Wayland Lightning Dodger - Dependency Installer

set -e

echo "=== FFX Wayland Lightning Dodger Installer ==="

# 1. Detect Package Manager and Install 'grim'
if command -v pacman &> /dev/null; then
    echo "Distro detected: Arch / CachyOS"
    sudo pacman -S --needed --noconfirm grim python-pillow python-evdev
elif command -v apt-get &> /dev/null; then
    echo "Distro detected: Ubuntu / Debian"
    sudo apt-get update
    sudo apt-get install -y grim python3-pillow python3-evdev
elif command -v dnf &> /dev/null; then
    echo "Distro detected: Fedora"
    sudo dnf install -y grim python3-pillow python3-evdev
else
    echo "⚠️ Unknown distribution. Please install 'grim', 'pillow', and 'evdev' manually."
fi

# 2. Configure uinput permissions so running the script doesn't require sudo
echo "Configuring /dev/uinput permissions..."
sudo usermod -aG input "$USER"

# Create a udev rule to ensure the input group can always access uinput
if [ ! -f /etc/udev/rules.d/85-uinput.rules ]; then
    echo 'KERNEL=="uinput", GROUP="input", MODE="0660", OPTIONS+="static_node=uinput"' | sudo tee /etc/udev/rules.d/85-uinput.rules > /dev/null
    sudo udevadm control --reload-rules && sudo udevadm trigger
fi

echo -e "\n✅ Setup complete!"
echo "⚠️ IMPORTANT: Please log out and log back in (or restart your terminal session) for the group permissions to take effect so you can run the script without sudo."
