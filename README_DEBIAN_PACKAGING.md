# ABDownloadManager Debian Packaging Setup

##  Overview

This directory contains a **production-ready Debian (.deb) packaging setup** for ABDownloadManager. All files follow Debian standards and are compatible with Ubuntu, Pop!_OS, and other Debian-based distributions.

##  What's Included

### Core Packaging Files (Ready to Use)
- **build-deb.sh** - Automated build script (just run this!)
- **DEBIAN_control** - Package metadata
- **DEBIAN_postinst** - Post-installation setup
- **DEBIAN_prerm** - Pre-removal cleanup
- **abdownloadmanager.desktop** - Application launcher

### Complete Documentation
- **QUICK_START.md** - Quick reference ( Start here!)
- **DEB_PACKAGING_GUIDE.md** - Comprehensive guide
- **PACKAGING_REFERENCE.md** - Technical reference
- **PACKAGING_SETUP_SUMMARY.txt** - Complete summary
- **FILE_CONTENTS_REFERENCE.txt** - All file contents

##  Quick Start (3 Commands)

### 1. Build the package
```bash
./build-deb.sh
```

### 2. Install the package
```bash
sudo dpkg -i abdownloadmanager_1.8.8_amd64.deb
```

### 3. Launch the application
```bash
abdownloadmanager
```

##  Requirements

The application must be **pre-built** and located at:
```
/opt/ABDownloadManager/
 bin/
    ABDownloadManager     (executable binary)
 lib/                      (optional)
 resources/                (optional)
 icon.png                  (required: PNG image)
```

##  What Gets Created

- **Output file**: `abdownloadmanager_1.8.8_amd64.deb`
- **Install to**: `/opt/ABDownloadManager/` (binary and resources)
- **Launcher**: `/usr/share/applications/abdownloadmanager.desktop`
- **Icon**: `/usr/share/icons/hicolor/256x256/apps/abdownloadmanager.png`

##  Build Process

The **build-deb.sh** script automatically:
1. Creates proper Debian package structure
2. Copies all required files
3. Sets correct permissions (755 for executables, 644 for configs)
4. Updates desktop application database (postinst)
5. Refreshes icon cache (postinst)
6. Builds the final `.deb` package
7. Verifies integrity and displays info

##  Documentation Guide

| File | Purpose | Best For |
|------|---------|----------|
| **QUICK_START.md** | Quick reference | Getting started immediately |
| **DEB_PACKAGING_GUIDE.md** | Comprehensive guide | Understanding everything |
| **PACKAGING_REFERENCE.md** | Technical details | Advanced customization |
| **PACKAGING_SETUP_SUMMARY.txt** | Complete reference | Complete overview |
| **FILE_CONTENTS_REFERENCE.txt** | File contents | Copy/paste reference |

##  Key Files

### build-deb.sh
Automated build script that:
- Validates prerequisites
- Creates temporary package structure
- Copies files with correct permissions
- Builds .deb using dpkg-deb
- Verifies output
- Shows installation instructions

### DEBIAN_control
Package metadata including:
- Package name: `abdownloadmanager`
- Version: `1.8.8`
- Architecture: `amd64`
- Dependencies
- Description and maintainer info

### DEBIAN_postinst
Automatic post-installation setup:
- Sets binary executable permissions
- Updates desktop application database
- Refreshes icon cache
- Enables immediate app availability

### abdownloadmanager.desktop
Application launcher entry:
- Name: ABDownloadManager
- Exec: `/opt/ABDownloadManager/bin/ABDownloadManager --no-sandbox`
- Icon: `abdownloadmanager`
- Categories: Network, Utility
- Terminal: false

##  Common Tasks

### Build the package
```bash
./build-deb.sh
```

### Install the package
```bash
sudo dpkg -i abdownloadmanager_1.8.8_amd64.deb
```

### Verify installation
```bash
dpkg -l | grep abdownloadmanager
```

### Check package contents
```bash
dpkg -c abdownloadmanager_1.8.8_amd64.deb
```

### View package info
```bash
dpkg -I abdownloadmanager_1.8.8_amd64.deb
```

### Remove the package
```bash
sudo dpkg -r abdownloadmanager
```

### Reinstall
```bash
sudo dpkg -r abdownloadmanager
./build-deb.sh
sudo dpkg -i abdownloadmanager_1.8.8_amd64.deb
```

##  Customization

### Change Version
1. Edit `build-deb.sh`: `VERSION="1.9.0"`
2. Edit `DEBIAN_control`: `Version: 1.9.0`

### Update Maintainer
Edit `DEBIAN_control`:
```
Maintainer: Your Name <your.email@example.com>
```

### Modify Dependencies
Edit `DEBIAN_control`:
```
Depends: libc6 (>= 2.17), libstdc++6 (>= 5.2), additional-package
```

### Change Categories
Edit `abdownloadmanager.desktop`:
```
Categories=Network;Utility;Office;
```

##  Troubleshooting

| Problem | Solution |
|---------|----------|
| Source not found | Ensure `/opt/ABDownloadManager/` exists |
| Permission denied | `chmod +x build-deb.sh` |
| App not in menu | `sudo update-desktop-database /usr/share/applications` |
| Icon not showing | `sudo gtk-update-icon-cache -f -t /usr/share/icons/hicolor` |
| Dependencies error | `sudo apt install -f` |

##  Features

 Production-ready Debian packaging  
 Follows Debian Policy Manual  
 Compatible with Ubuntu and Pop!_OS  
 Automatic desktop database updates  
 Icon cache refresh on install  
 Proper file permissions  
 Error handling in scripts  
 Comprehensive documentation  
 Easy customization  
 Full compliance with standards  

##  Learning Resources

- **[Debian Policy Manual](https://www.debian.org/doc/debian-policy/)**
- **[Desktop Entry Specification](https://specifications.freedesktop.org/desktop-entry-spec/)**
- **[XDG Icon Theme](https://specifications.freedesktop.org/icon-theme-spec/)**
- **[Filesystem Hierarchy Standard](https://refspecs.linuxfoundation.org/FHS_3.0/fhs-3.0.html)**

##  Distribution

The generated `.deb` file can be:
- **Shared directly** - Email, file sharing, USB
- **GitHub Releases** - Easy access for users
- **APT Repository** - Professional distribution
- **Linux Distributions** - Official repositories

##  Verification Checklist

Before building:
- [ ] Application compiled and ready
- [ ] Binary at `/opt/ABDownloadManager/bin/ABDownloadManager`
- [ ] Icon present at `/opt/ABDownloadManager/icon.png`
- [ ] Maintainer info correct in `DEBIAN_control`
- [ ] Version numbers match in all files
- [ ] Dependencies are accurate

After building:
- [ ] `.deb` file created successfully
- [ ] Package info shows correct metadata
- [ ] Installation succeeds without errors
- [ ] Application appears in menu
- [ ] Icon displays correctly
- [ ] Application launches successfully

##  Ready to Build?

1. Start with **QUICK_START.md**
2. Run: `./build-deb.sh`
3. Install: `sudo dpkg -i abdownloadmanager_1.8.8_amd64.deb`
4. Distribute!

##  Support

For detailed information:
- Read **QUICK_START.md** for immediate help
- Check **DEB_PACKAGING_GUIDE.md** for comprehensive guide
- Review **PACKAGING_REFERENCE.md** for technical details
- See **FILE_CONTENTS_REFERENCE.txt** for all file contents

---

**Status**:  Production Ready  
**Version**: 1.8.8  
**Architecture**: amd64  
**Maintainer**: Nohan  
**Last Updated**: 2026-04-18

