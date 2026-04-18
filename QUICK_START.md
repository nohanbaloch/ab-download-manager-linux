# Quick Start: Building & Installing ABDownloadManager .deb

##  Quick Build (5 minutes)

### Prerequisites

Ensure the application is built at:

```dir
/opt/ABDownloadManager/bin/ABDownloadManager
```

### Build the Package

```bash
cd /home/nohan/Workspace/Apps/ab-download-manager-linux
./build-deb.sh
```

You'll see:

```
Building Debian package for abdownloadmanager...
Creating package directory structure...
Copying DEBIAN metadata files...
Copying application files...
Copying desktop launcher...
Copying application icon...
Building .deb package...
 Package created successfully: abdownloadmanager_1.8.8_amd64.deb
...
Build completed successfully!
Installation command:
  sudo dpkg -i abdownloadmanager_1.8.8_amd64.deb
```

### Install the Package

```bash
sudo dpkg -i abdownloadmanager_1.8.8_amd64.deb
```

### Verify Installation

```bash
# Method 1: Launch from applications menu
# (Search for "ABDownloadManager" in your application launcher)

# Method 2: Launch from terminal
abdownloadmanager

# Method 3: Direct launch
/opt/ABDownloadManager/bin/ABDownloadManager --no-sandbox
```

---

##  What Gets Created

**Generated File**: `abdownloadmanager_1.8.8_amd64.deb`

**Installation Locations**:

- Binary: `/opt/ABDownloadManager/bin/ABDownloadManager`
- Desktop Launcher: `/usr/share/applications/abdownloadmanager.desktop`
- Icon: `/usr/share/icons/hicolor/256x256/apps/abdownloadmanager.png`

---

##  Files Provided

| File | Purpose |
|------|---------|
| `build-deb.sh` | Build automation script (run this!) |
| `DEBIAN_control` | Package metadata |
| `DEBIAN_postinst` | Post-install setup |
| `DEBIAN_prerm` | Pre-remove cleanup |
| `abdownloadmanager.desktop` | Application launcher |
| `DEB_PACKAGING_GUIDE.md` | Detailed documentation |
| `PACKAGING_REFERENCE.md` | Complete reference |

---

##  Common Tasks

### Remove the Package

```bash
sudo dpkg -r abdownloadmanager
```

### Rebuild the Package

```bash
./build-deb.sh
```

### Change Version Number

Edit `build-deb.sh`:

```bash
VERSION="1.9.0"
```

Also update `DEBIAN_control`:
```
Version: 1.9.0
```

Then rebuild.

### Verify Package Contents

```bash
dpkg -c abdownloadmanager_1.8.8_amd64.deb
```

### Check Package Info

```bash
dpkg -I abdownloadmanager_1.8.8_amd64.deb
```

---

##  Checklist Before Building

- [ ] Application compiled and located at `/opt/ABDownloadManager/`
- [ ] Binary file exists at `/opt/ABDownloadManager/bin/ABDownloadManager`
- [ ] Icon exists at `/opt/ABDownloadManager/icon.png`
- [ ] You have read/write permissions in the project directory
- [ ] `dpkg` is installed: `which dpkg`

If dpkg is missing:
```bash
sudo apt update
sudo apt install dpkg
```

---

##  Troubleshooting

### "Source application not found at /opt/ABDownloadManager"
**Solution**: Build and install application at that location first

### "Permission denied" when running build-deb.sh
**Solution**: Make script executable
```bash
chmod +x build-deb.sh
./build-deb.sh
```

### Application doesn't appear in application menu after install
**Solution**: Refresh desktop database
```bash
sudo update-desktop-database /usr/share/applications
```

### Icon not showing
**Solution**: Refresh icon cache
```bash
sudo gtk-update-icon-cache -f -t /usr/share/icons/hicolor
```

### Dependency errors during installation
**Solution**: Install missing dependencies
```bash
sudo apt install -f
```

---

##  Full Documentation

For detailed information, see:
- **DEB_PACKAGING_GUIDE.md** - Complete usage guide
- **PACKAGING_REFERENCE.md** - Technical reference

---

##  What Happens on Install

When you run `sudo dpkg -i abdownloadmanager_1.8.8_amd64.deb`:

1. **Extracts files**:
   - Binary → `/opt/ABDownloadManager/bin/`
   - Icon → `/usr/share/icons/hicolor/256x256/apps/`
   - Launcher → `/usr/share/applications/`

2. **Runs postinst script** (automatic):
   - Sets executable permissions on binary
   - Updates application database
   - Refreshes icon cache

3. **Ready to use**:
   - Application appears in launcher
   - Icon displays correctly
   - Ready to launch

---

##  Distribution

The generated `.deb` file can be:

- **Shared directly**: Email, file sharing, etc.
- **Hosted on GitHub**: Upload to releases
- **Hosted on APT repo**: Create custom repository
- **Submitted to distributions**: Ubuntu, Pop!_OS, etc.

---

##  System Requirements

**Minimum Requirements**:
- Debian/Ubuntu-based Linux (Ubuntu 18.04+, Pop!_OS, Debian 10+)
- dpkg (package management)
- libc6 >= 2.17
- libstdc++6 >= 5.2

**Recommended**:
- dpkg-dev (for advanced packaging)
- update-desktop-database (auto-installed)
- gtk-update-icon-cache (auto-installed)

---

##  Support

For packaging issues:
1. Check `DEB_PACKAGING_GUIDE.md` troubleshooting section
2. Verify `build-deb.sh` output messages
3. Run: `dpkg -I abdownloadmanager_1.8.8_amd64.deb` to inspect package

---

**Happy packaging!**
