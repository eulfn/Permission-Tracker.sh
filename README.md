# Android Permission Report Script

Quick shell script to list which apps have Camera, Mic, or Location access on your Android device. Works with root or Shizuku shell. Output is clean and easy to read.

## What It Does
- Lists all user apps with access to:
  - 📷 Camera
  - 🎙️ Microphone
  - 📍 Location
- Uses `pm` and `appops` to check real permission status.
- Lets you filter by permission or export the report.
- Variable and function names are short and snappy on purpose.

## How To Use
1. Save the script as `permission_report.sh` on your device.
2. Make it executable:
   ```sh
   chmod +x permission_report.sh
   ```
3. Run it in a root shell or Shizuku shell:
   ```sh
   ./permission_report.sh
   ```

## Flags
- `--camera`   Only show apps with camera access
- `--mic`      Only show apps with mic access
- `--location` Only show apps with location access
- `--all`      Show all (default)
- `--export`   Save the report to `/sdcard/permission_report.txt`

You can combine flags, e.g.:
```sh
./permission_report.sh --mic --export
```

## Output Example
```
📷 CAMERA:
- com.whatsapp
- com.instagram.android

🎙️ MICROPHONE:
- com.discord
- com.zoom.android

📍 LOCATION:
- com.google.android.apps.maps
- com.grabtaxi.passenger
```

## Requirements
- Android 8.0+
- `pm` and `appops` available in shell
- Root or Shizuku shell access

## Why the Short Names?
Because it's fast to write, easy to read, and fun. Functions like `Has` and `Op` do what they say. Variables like `p`, `pkgs`, `cam_list` keep things simple.

---

PRs welcome if you want to add more features or make it fancier! 