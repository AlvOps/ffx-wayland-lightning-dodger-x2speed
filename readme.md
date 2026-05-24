
# FFX Wayland Lightning Dodger

A robust, performance-oriented auto lightning-dodge script for **Final Fantasy X HD Remaster** running natively on **Linux via Steam/Proton**.

Unlike standard Windows AutoHotkey (AHK) scripts or basic Python alternatives that break under Wayland and Proton, this tool uses low-level Linux kernel subsystems to ensure sub-millisecond precision and reliable input execution.

## 🚀 Key Features

* **Wayland Native:** Uses `grim` to sample raw uncompressed PPM pixel data directly from your compositor. No X11 dependencies.
* **Kernel-Level Input Injection:** Utilizes `evdev` and the Linux `/dev/input/uinput` interface to simulate a real physical hardware keyboard. This safely bypasses SDL2/Proton input hooks that often ignore user-space simulated keys.
* **Game Speed x2 Booster Support:** Implements a sustained 1-second background key-hold thread. This guarantees the engine catches the keystroke input buffer even when the game is running at double speed (`x2`).
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
```

---

## 🎮 How to Run (Step-by-Step Guide)

Follow this precise sequence to execute the script successfully:

1. **Refresh User Groups**
   After running `setup.sh`, you **must log out and log back in** (or reboot) so the newly assigned `input` group permissions take effect on your user session. This allows you to run the script securely without needing raw `sudo`.

2. **Disconnect Controllers**
   Unplug or turn off your physical gamepad/controller entirely. *Final Fantasy X* locks input onto controllers if detected; disconnecting them forces the game engine to fall back to native keyboard mode.

3. **In-Game Positioning**
   * Launch *Final Fantasy X* through Steam.
   * Head to the northern section of the **Thunder Plains**.
   * Stand completely still directly in front of a **Qactuar (Cactuar) Stone**. Lightning will strike infinitely in front of it without you having to walk around.
   * Activate the built-in **x2 game speed booster**.

   <img width="632" height="307" alt="image" src="https://github.com/user-attachments/assets/7793b49f-c392-4e37-9b4b-fd6bfbfd8c02" />

4. **Execute the Script**
   Open your Linux terminal, navigate to the script directory, and execute:
   ```bash
   python3 ffx_cactilio_hold.py
   
   > 💡 **Note:** If you haven't rebooted or logged out yet, you can use `sudo -E python3 ffx_cactilio_hold.py` as a temporary workaround.

5. **Focus & Collect**
   Immediately switch window focus back to your running game. Watch the terminal count your dodges. Once you cross the target threshold safely (e.g., **205 to 210 dodges**), press `Ctrl + C` in the terminal to stop the loop. Reconnect your controller and claim your **Mars Sigil** from the chest at the Travel Agency!

---

## 📍 Custom Configuration

By default, the script watches a tiny **10x10** bounding box centered around the screen coordinates `1275,715`.

* **Where to aim:** Ensure the bounding box covers an area of the dark background scenery (such as the dark sky or ground) that turns bright white during a lightning strike. 
* **What to avoid:** Avoid placing the box over the Qactuar Stone itself, UI elements, or character models to prevent false brightness positives.
* **Adjusting resolution:** If your monitor resolution, game window positioning, or UI scale differ


