# ABDownloadManager Debian Packaging Guide

## Overview

This packaging setup creates a production-ready Debian (.deb) package for ABDownloadManager. It follows Debian packaging standards and is compatible with Ubuntu, Pop!_OS, and other Debian-based distributions.

## File Structure

```
ab-download-manager-linux/
 DEBIAN_control              # Package metadata
 DEBIAN_postinst             # Post-installation script
 DEBIAN_prerm                # Pre-removal script
 abdownloadmanager.desktop   # Desktop launcher file
 build-deb.sh                # Build automation script
```

## Files Created

### 1. DEBIAN_control
**Purpose**: Package metadata file
**Location**: Will be placed in `DEBIAN/control` inside the .deb

```
Package: abdownloadmanager
Version: 1.8.8
Section: net
Priority: optional
Architecture: amd64
Maintainer: Nohan <nohan@example.com>
Homepage: https://github.com/amir1376/ab-download-manager
Installed-Size: 1024
Depends: libc6 (>= 2.17), libstdc++6 (>= 5.2)
Description: Fast and modern download manager.
```

**Details**:
- **Package**: Lowercase package identifier
- **Version**: Semantic versioning (1.8.8)
- **Section**: Category (net for network applications)
- **Architecture**: amd64 for 64-bit systems
- **Depends**: Runtime dependencies

### 2. DEBIAN_postinst
**Purpose**: Post-installation setup script
**Execution**: Runs after package installation

```bash
#!/bin/bash
set -e

# Make the binary executable
chmod 755 /opt/ABDownloadManager/bin/ABDownloadManager

# Update desktop database
update-desktop-database /usr/share/applications || true

# Update icon cache
gtk-update-icon-cache -f -t /usr/share/icons/hicolor || true

exit 0
```

**Tasks**:
- Sets executable permissions on the binary
- Updates desktop application database
- Refreshes icon cache for immediate appearance in applications menu
- Uses `set -e` for error handling
- Uses `|| true` to prevent failures if commands are missing

### 3. DEBIAN_prerm
**Purpose**: Pre-removal cleanup script
**Execution**: Runs before package removal

```bash
#!/bin/bash
set -e

exit 0
```

**Notes**: 
- Currently minimal as cleanup isn't needed for removal
- Can be extended for database cleanup or configuration preservation

### 4. abdownloadmanager.desktop
**Purpose**: Desktop application launcher
**Location**: `/usr/share/applications/abdownloadmanager.desktop`

```
[Desktop Entry]
Version=1.0
Type=Application
Name=ABDownloadManager
Comment=Fast and modern download manager
Exec=/opt/ABDownloadManager/bin/ABDownloadManager --no-sandbox
Icon=abdownloadmanager
Terminal=false
Categories=Network;Utility;
StartupNotify=true
Keywords=download;manager;torrent;
```

**Fields**:
- **Name**: Display name in applications menu
- **Exec**: Command to launch (with --no-sandbox flag)
- **Icon**: References icon at `/usr/share/icons/hicolor/256x256/apps/abdownloadmanager.png`
- **Terminal**: false (don't open terminal window)
- **Categories**: Appears in Network and Utility categories
- **StartupNotify**: Shows busy cursor while launching

### 5. build-deb.sh
**Purpose**: Automated package building script
**Permissions**: Executable (755)

**Features**:
- Validates source application exists
- Creates proper directory structure
- Copies application files with correct permissions
- Copies metadata and desktop files
- Builds .deb using dpkg-deb
- Verifies package integrity
- Displays colorized output

**Usage**:
```bash
./build-deb.sh
```

**Output**:
- Creates: `abdownloadmanager_1.8.8_amd64.deb`
- Shows package contents and metadata
- Ready for installation or distribution

## Installation Instructions

### Prerequisites

Ensure the application is built at `/opt/ABDownloadManager`:
```
/opt/ABDownloadManager/
 bin/
    ABDownloadManager    (executable)
 lib/                     (optional)
 resources/               (optional)
 icon.png                 (required)
```

### Building the Package

1. Navigate to the project directory:
```bash
cd /home/nohan/Workspace/Apps/ab-download-manager-linux
```

2. Run the build script:
```bash
./build-deb.sh
```

3. The script will:
   - Create temporary package structure
   - Copy application files
   - Build the .deb package
   - Display package information
   - Output `abdownloadmanager_1.8.8_amd64.deb`

### Installing the Package

```bash
# Install the package
sudo dpkg -i abdownloadmanager_1.8.8_amd64.deb

# Verify installation
dpkg -l | grep abdownloadmanager
```

### Removing the Package

```bash
sudo dpkg -r abdownloadmanager
```

## File Placement After Installation

After running `./build-deb.sh` and installing the package, files will be placed at:

```
/opt/ABDownloadManager/           # Application files
/usr/share/applications/          # Desktop launcher
/usr/share/icons/hicolor/         # Application icon
```

## Desktop Entry Verification

After installation, verify the desktop file:

```bash
# Check if recognized by desktop database
desktop-file-validate /usr/share/applications/abdownloadmanager.desktop

# Launch from command line
abdownloadmanager

# Or directly
/opt/ABDownloadManager/bin/ABDownloadManager --no-sandbox
```

## Debian Packaging Standards

This setup follows Debian Policy Manual (DPM) requirements:

 **Control file** with required fields (Package, Version, Architecture, Maintainer, Description)
 **Proper permissions** on scripts (755 for executables, 644 for configs)
 **Desktop file** complies with freedesktop.org specification
 **Icon placement** follows XDG icon theme specification
 **Maintainer scripts** use proper bash with `set -e`
 **Dependencies** explicitly declared
 **Architecture** specific (amd64)

## Customization Options

### Change Version Number

Edit `build-deb.sh`:
```bash
VERSION="1.9.0"  # Change version
```

Also update `DEBIAN_control`:
```
Version: 1.9.0
```

### Change Maintainer

Edit `DEBIAN_control`:
```
Maintainer: Your Name <your.email@example.com>
Homepage: https://your-project-url
```

### Add Dependencies

Edit `DEBIAN_control`:
```
Depends: libc6 (>= 2.17), libstdc++6 (>= 5.2), additional-package
```

### Update Icon

Replace `/opt/ABDownloadManager/icon.png` with your icon (PNG format, 256x256 or larger).

### Modify Desktop Categories

Edit `abdownloadmanager.desktop`:
```
Categories=Network;Utility;Office;
```

Standard categories: Network, Utility, Development, Office, Science, Graphics, Multimedia, etc.

## Testing on Different Distributions

### Ubuntu/Pop!_OS
```bash
sudo dpkg -i abdownloadmanager_1.8.8_amd64.deb
```

### With Dependencies
If dependencies are missing, use apt to resolve:
```bash
sudo apt install -f  # Install missing dependencies
```

### Lint Desktop File (Optional)
```bash
desktop-file-validate usr/share/applications/abdownloadmanager.desktop
```

## Troubleshooting

### Package fails to install
- **Check dependencies**: `dpkg -I abdownloadmanager_1.8.8_amd64.deb`
- **View detailed errors**: `sudo dpkg -i abdownloadmanager_1.8.8_amd64.deb --debug=5`

### Application doesn't appear in launcher
- Run: `sudo update-desktop-database /usr/share/applications`
- Run: `gtk-update-icon-cache -f -t /usr/share/icons/hicolor`

### Icon not showing
- Verify icon exists: `ls /usr/share/icons/hicolor/256x256/apps/abdownloadmanager.png`
- Rebuild cache: `sudo gtk-update-icon-cache -f -t /usr/share/icons/hicolor`

### Binary not executable
- Fix permissions: `sudo chmod 755 /opt/ABDownloadManager/bin/ABDownloadManager`

## Distribution

The generated `.deb` file can be:
- Distributed directly to users
- Hosted in a custom APT repository
- Submitted to Linux distributions

## Additional Resources

- [Debian New Maintainers' Guide](https://www.debian.org/doc/manuals/debmake-doc/index.en.html)
- [Debian Policy Manual](https://www.debian.org/doc/debian-policy/)
- [Desktop Entry Specification](https://specifications.freedesktop.org/desktop-entry-spec/)
- [XDG Icon Theme Specification](https://specifications.freedesktop.org/icon-theme-spec/)
