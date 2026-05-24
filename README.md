# FFX Wayland Lightning Dodger

A robust, performance-oriented auto lightning-dodge script for **Final Fantasy X HD Remaster** running natively on **Linux via Steam/Proton**.

Unlike standard Windows AutoHotkey (AHK) scripts or basic Python alternatives that break under Wayland and Proton, this script uses low-level Linux subsystems to ensure sub-millisecond precision.

## 🚀 Key Features
* **Wayland Native:** Uses `grim` to sample raw uncompressed PPM pixel data directly from the display server. No X11 dependencies.
* **Kernel-Level Input Injection:** Utilizes `evdev` and the Linux `/dev/input/uinput` interface to create a virtual physical hardware keyboard. This safely bypasses SDL/Proton input hooks that often ignore user-space simulated keys.
* **Game Speed x2 Booster Support:** Implements a sustained 1-second background key-hold thread. This guarantees the engine catches the keystroke input buffer even when the game is running at double speed.
* **Low Overhead:** Zero bloated image-processing pipelines; reads pixel states efficiently using native `Pillow` memory blocks.

## 🛠️ Prerequisites

Ensure your user is part of the `input` group to interact with `uinput`, or run the script with administrative privileges. 

Install the required system utility and Python packages:
```bash
# Arch / CachyOS
sudo pacman -S grim

# Python dependencies
pip install evdev pillow
