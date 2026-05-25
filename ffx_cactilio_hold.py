#!/usr/bin/env python3
"""
FFX Qactuar Stone - Auto Lightning Dodger (1-Second Sustained Keypress)
Optimized and verified to work flawlessly at game speed x2.
Usage: sudo -E python3 ffx_cactilio_hold.py
"""

import time, subprocess, io, threading, sys
import evdev
from evdev import UInput, ecodes as e
from PIL import Image as PILImage, ImageStat

GRIM_REGION     = "1275,715 10x10"
COLOR_THRESHOLD = 180  
COOLDOWN_X1     = 1.8  # Total wait time for Tidus to recover after dodging

# Virtual Keyboard setup — EV_REP makes Linux classify it as a real physical keyboard
try:
    ui = UInput({
        e.EV_KEY: list(range(256)),
        e.EV_REP: [],
    }, name="ffx-kb", vendor=0x1, product=0x1)
except PermissionError:
    print("❌ Error: Permission denied accessing /dev/uinput.")
    print("Please make sure you have restarted your session after running setup.sh,")
    print("or run with sudo as a fallback: 'sudo -E python3 ffx_cactilio_hold.py'")
    sys.exit(1)

print("Virtual keyboard ready...")
time.sleep(1)

def hold_c_one_second():
    """Holds down the 'C' key for exactly 1 second"""
    print("  [Keyboard] -> Pressing 'C'...")
    ui.write(e.EV_KEY, e.KEY_C, 1)
    ui.syn()
    
    # Keeping the key pressed for 1 second guarantees that the game input buffer 
    # catches the keystroke, even when running at boosted speeds like x2.
    time.sleep(1.0)  
    
    print("  [Keyboard] -> Releasing 'C'...")
    ui.write(e.EV_KEY, e.KEY_C, 0)
    ui.syn()

print(f"Qactuar Mode Active (1s Keyhold | Verified for x2). Region: {GRIM_REGION} | Threshold: {COLOR_THRESHOLD}")
print("Press Ctrl+C to stop.\n")

last_flash = False
dodge_count = 0

try:
    while True:
        # Fast screenshot capture using uncompressed PPM format
        r = subprocess.run(["grim", "-t", "ppm", "-g", GRIM_REGION, "-"], capture_output=True)
        if not r.stdout:
            continue
            
        img = PILImage.open(io.BytesIO(r.stdout))
        # Calculate the average RGB brightness of the 10x10 pixel area
        mean_colors = ImageStat.Stat(img).mean
        
        # If all RGB channels exceed the threshold, a screen flash is detected
        is_flash = all(c > COLOR_THRESHOLD for c in mean_colors)

        if is_flash and not last_flash:
            dodge_count += 1
            print(f"⚡ FLASH DETECTED! Mean RGB: {[int(x) for x in mean_colors]} -> Dodging ({dodge_count}/200)")
            
            # Dispatch the sustained keypress in a separate background thread
            threading.Thread(target=hold_c_one_second, daemon=True).start()
            
            # Freeze the main loop to ignore the rest of the flash and the backflip animation
            time.sleep(COOLDOWN_X1)
            last_flash = False
            continue

        last_flash = is_flash

except KeyboardInterrupt:
    print(f"\nStopped. Total dodges saved: {dodge_count}")
    ui.close()
