# FFX Wayland Lightning Dodger

A robust, performance-oriented auto lightning-dodge script for **Final Fantasy X HD Remaster** running natively on **Linux via Steam/Proton**.

Unlike standard Windows AutoHotkey (AHK) scripts or basic Python alternatives that break under Wayland and Proton, this tool uses low-level Linux kernel subsystems to ensure sub-millisecond precision and reliable input execution.

## 🚀 Key Features

* **Wayland Native:** Uses `grim` to sample raw uncompressed PPM pixel data directly from your compositor. No X11 dependencies.
* **Kernel-Level Input Injection:** Utilizes `evdev` and the Linux `/dev/input/uinput` interface to simulate a real physical hardware keyboard. This safely bypasses SDL2/Proton input hooks that often ignore user-space simulated keys.
* **Game Speed x2 Booster Support:** Implements a sustained 1-second background key-hold thread. This guarantees the engine catches the keystroke input buffer even when the game is running at double speed ($x2$).
* **Low Overhead:** Zero bloated image-processing pipelines; reads pixel states efficiently using native `Pillow` memory blocks.
* **Hassle-Free Installer:** Includes a complete `setup.sh` script to configure system packages, `udev` rules, and user permissions automatically.

---

## 📂 Repository Structure

The repository consists of the following files:
* `setup.sh` — Automated dependency installer and system configuration script.
* `ffx_cactilio_hold.py` — The core Python script that manages the screen polling and key execution loop.
* `LICENSE` — Licensed under the professional and permissive MIT License.
* `README.md` — Documentation and usage guide.

---

## 🛠️ Installation & Setup

Clone the repository and run the automated installation script. It detects your package manager (Arch/CachyOS, Ubuntu/Debian, or Fedora), installs `grim`, installs Python dependencies, and configures permissions for `/dev/uinput`:

```bash
chmod +x setup.sh
./setup.sh
