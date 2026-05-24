#!/usr/bin/env bash
# FFX Wayland Lightning Dodger - Dependency Installer and Configurator
set -e

echo "================================================="
echo "   FFX Wayland Lightning Dodger - Installer"
echo "================================================="

# 1. Detect Package Manager and Install 'grim'
if command -v pacman &> /dev/null; then
    echo "[+] Distro detected: Arch / CachyOS"
    sudo pacman -S --needed --noconfirm grim python-pillow python-evdev
elif command -v apt-get &> /dev/null; then
    echo "[+] Distro detected: Ubuntu / Debian"
    sudo apt-get update
    sudo apt-get install -y grim python3-pillow python3-evdev
elif command -v dnf &> /dev/null; then
    echo "[+] Distro detected: Fedora"
    sudo dnf install -y grim python3-pillow python3-evdev
else
    echo "⚠️ Unknown distribution. Please install 'grim', 'pillow', and 'evdev' manually."
fi

# 2. Configure uinput permissions so running the script doesn't require raw sudo
echo "[+] Configuring /dev/uinput permissions..."
sudo usermod -aG input "$USER"

# Create a udev rule to ensure the input group can always access uinput
if [ ! -f /etc/udev/rules.d/85-uinput.rules ]; then
    echo 'KERNEL=="uinput", GROUP="input", MODE="0660", OPTIONS+="static_node=uinput"' | sudo tee /etc/udev/rules.d/85-uinput.rules > /dev/null
    sudo udevadm control --reload-rules && sudo udevadm trigger
fi

echo -e "\n✅ Installation complete!"
echo "================================================="
echo "🚀 HOW TO RUN THE SCRIPT AFTER INSTALLATION"
echo "================================================="
echo "1. ⚠️ LOG OUT AND LOG BACK IN (or reboot) for group permissions to apply."
echo "2. Disconnect your gamepad/controller from your PC entirely."
echo "3. Launch FFX HD Remaster on Steam (it will load in native Keyboard Mode)."
echo "4. Stand Tidus completely still in front of a Qactuar (Cactuar) Stone."
echo "5. Enable the x2 Game Speed Booster."
echo "6. Run the script from your terminal:"
echo "   python3 ffx_cactilio_hold.py"
echo "7. Focus back into the game window and watch the counter fly!"
echo "8. Press Ctrl+C in the terminal once you cross 200 dodges."
echo "================================================="#!/usr/bin/env bash
echo "================================================="#!/usr/bin/env bash
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
