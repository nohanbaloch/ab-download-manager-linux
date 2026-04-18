# Debian Packaging Files - Complete Reference

## Directory Structure After Running build-deb.sh

```
abdownloadmanager-1.8.8-amd64/          (temporary, created during build)
 DEBIAN/
    control
    postinst
    prerm
 opt/ABDownloadManager/
    bin/ABDownloadManager
    lib/
    resources/
    icon.png
 usr/share/
     applications/
        abdownloadmanager.desktop
     icons/hicolor/256x256/apps/
         abdownloadmanager.png

Output: abdownloadmanager_1.8.8_amd64.deb
```

## File Contents Reference

### 1. DEBIAN_control
**Type**: Package metadata
**Permissions**: 644
**Becomes**: DEBIAN/control inside .deb

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
 ABDownloadManager is a feature-rich download manager for Linux with a modern
 user interface. It provides fast, reliable download management with support
 for multiple simultaneous downloads.
```

### 2. DEBIAN_postinst
**Type**: Shell script (executable)
**Permissions**: 755
**Becomes**: DEBIAN/postinst inside .deb
**Executed**: After package installation

```bash
#!/bin/bash
set -e

# Make the binary executable
if [ -f /opt/ABDownloadManager/bin/ABDownloadManager ]; then
    chmod 755 /opt/ABDownloadManager/bin/ABDownloadManager
fi

# Update desktop database
if command -v update-desktop-database &> /dev/null; then
    update-desktop-database /usr/share/applications || true
fi

# Update icon cache
if command -v gtk-update-icon-cache &> /dev/null; then
    gtk-update-icon-cache -f -t /usr/share/icons/hicolor || true
fi

exit 0
```

### 3. DEBIAN_prerm
**Type**: Shell script (executable)
**Permissions**: 755
**Becomes**: DEBIAN/prerm inside .deb
**Executed**: Before package removal

```bash
#!/bin/bash
set -e

exit 0
```

### 4. abdownloadmanager.desktop
**Type**: Desktop Entry file
**Permissions**: 644
**Location**: /usr/share/applications/abdownloadmanager.desktop
**Standard**: freedesktop.org Desktop Entry Specification

```ini
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

### 5. build-deb.sh
**Type**: Bash build automation script
**Permissions**: 755 (executable)
**Purpose**: Creates the complete .deb package

Key features:
- Pre-flight checks (source directory exists)
- Creates temporary package structure
- Copies files with correct permissions
- Handles missing optional files gracefully
- Builds .deb using dpkg-deb
- Verifies output package
- Displays colorized progress

Usage:
```bash
./build-deb.sh
```

Output:
```
abdownloadmanager_1.8.8_amd64.deb
```

## Installation Flow

### Step 1: Prepare Application (prerequisite)
```bash
mkdir -p /opt/ABDownloadManager/bin
mkdir -p /opt/ABDownloadManager/lib
mkdir -p /opt/ABDownloadManager/resources

# Copy your compiled binary
cp your-compiled-binary /opt/ABDownloadManager/bin/ABDownloadManager
chmod 755 /opt/ABDownloadManager/bin/ABDownloadManager

# Copy resources if any
cp -r resources /opt/ABDownloadManager/

# Copy icon
cp icon.png /opt/ABDownloadManager/
```

### Step 2: Build Package
```bash
cd /path/to/ab-download-manager-linux
./build-deb.sh
```

### Step 3: Install Package
```bash
sudo dpkg -i abdownloadmanager_1.8.8_amd64.deb
```

### Step 4: Post-Installation
Automatic via postinst script:
- Binary permissions set
- Desktop database updated
- Icon cache refreshed

### Step 5: Verify Installation
```bash
# Check package
dpkg -l | grep abdownloadmanager

# Launch application
abdownloadmanager

# Or directly
/opt/ABDownloadManager/bin/ABDownloadManager --no-sandbox
```

## Permissions Matrix

| File | Permission | Reason |
|------|-----------|--------|
| DEBIAN/control | 644 | Configuration file |
| DEBIAN/postinst | 755 | Executable shell script |
| DEBIAN/prerm | 755 | Executable shell script |
| /opt/ABDownloadManager/bin/ABDownloadManager | 755 | Executable binary |
| /usr/share/applications/abdownloadmanager.desktop | 644 | Configuration file |
| /usr/share/icons/hicolor/.../abdownloadmanager.png | 644 | Image resource |

## Debian Standards Compliance

 **Package Naming**: `abdownloadmanager_VERSION_ARCH.deb`
 **Control File**: Contains all required fields
 **Architecture Specification**: amd64 (explicit)
 **Version Format**: Debian versioning (1.8.8)
 **Section**: net (appropriate for download manager)
 **Priority**: optional (correct default)
 **Maintainer**: Name and email
 **Dependencies**: Explicit libc6 and libstdc++6
 **Scripts**: Proper bash with error handling
 **Desktop File**: Follows freedesktop spec
 **Icon Placement**: XDG icon theme standard

## Customization Checklist

Before building, verify/customize:

- [ ] Application built and located at `/opt/ABDownloadManager/`
- [ ] Binary at `/opt/ABDownloadManager/bin/ABDownloadManager` is executable
- [ ] Icon present at `/opt/ABDownloadManager/icon.png`
- [ ] Maintainer name correct in DEBIAN_control
- [ ] Homepage URL updated in DEBIAN_control
- [ ] Version number matches in DEBIAN_control and build-deb.sh
- [ ] Dependencies listed in DEBIAN_control are accurate
- [ ] Desktop file categories are appropriate
- [ ] Launch command correct in desktop file

## Package Verification

After building, verify the .deb file:

```bash
# View package info
dpkg -I abdownloadmanager_1.8.8_amd64.deb

# View file list
dpkg -c abdownloadmanager_1.8.8_amd64.deb

# Test installation (dry-run)
sudo dpkg --dry-run -i abdownloadmanager_1.8.8_amd64.deb

# Lint desktop file
desktop-file-validate usr/share/applications/abdownloadmanager.desktop
```

## Distribution Methods

### 1. Direct Distribution
- Share the .deb file directly with users
- Users install via: `sudo dpkg -i abdownloadmanager_1.8.8_amd64.deb`

### 2. APT Repository
- Host in personal/organization APT repository
- Users add source: `sudo add-apt-repository ppa:username/ppa`
- Users install via: `sudo apt install abdownloadmanager`

### 3. Software Center
- Submit to Ubuntu AppCenter, GNOME Software, etc.
- Platform-specific submission requirements

### 4. GitHub Releases
- Upload .deb to GitHub releases
- Easy for users to download and install

## Performance Notes

- Build time: < 1 second
- Package size: Depends on application (typically 10-50MB)
- Installation time: < 5 seconds
- Uninstallation: Automatic cleanup via dpkg

## Troubleshooting Commands

```bash
# If dependencies are missing
sudo apt install -f

# If desktop entry not recognized
sudo update-desktop-database /usr/share/applications

# If icon not showing
sudo gtk-update-icon-cache -f -t /usr/share/icons/hicolor

# To reinstall package
sudo dpkg -r abdownloadmanager
./build-deb.sh
sudo dpkg -i abdownloadmanager_1.8.8_amd64.deb

# Check postinst script output
sudo dpkg -i --debug=3 abdownloadmanager_1.8.8_amd64.deb

# View full package contents
ar -t abdownloadmanager_1.8.8_amd64.deb
```

## Advanced: Creating Custom Installer

To create a complete installer experience, you could:

1. Add changelog file (DEBIAN/changelog)
2. Add license file (DEBIAN/copyright)
3. Create conffiles for configuration
4. Add triggers for heavy lifting
5. Create .orig.tar.gz source package

These are optional for basic distribution but recommended for official repositories.
