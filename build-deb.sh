#!/bin/bash

set -e

# Configuration
PACKAGE_NAME="abdownloadmanager"
VERSION="1.8.8"
ARCH="amd64"
PACKAGE_DIR="${PACKAGE_NAME}-${VERSION}-${ARCH}"
DEB_FILENAME="${PACKAGE_NAME}_${VERSION}_${ARCH}.deb"

# Source directory where built application resides
SOURCE_APP_DIR="/opt/ABDownloadManager"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo -e "${YELLOW}Building Debian package for ${PACKAGE_NAME}...${NC}"

# Check if source application exists
if [ ! -d "$SOURCE_APP_DIR" ]; then
    echo -e "${RED}Error: Source application not found at $SOURCE_APP_DIR${NC}"
    exit 1
fi

# Clean up previous builds
if [ -d "$PACKAGE_DIR" ]; then
    echo -e "${YELLOW}Cleaning up previous build directory...${NC}"
    rm -rf "$PACKAGE_DIR"
fi

if [ -f "$DEB_FILENAME" ]; then
    echo -e "${YELLOW}Removing previous .deb file...${NC}"
    rm -f "$DEB_FILENAME"
fi

# Create package directory structure
echo -e "${YELLOW}Creating package directory structure...${NC}"

mkdir -p "$PACKAGE_DIR/DEBIAN"
mkdir -p "$PACKAGE_DIR/opt/ABDownloadManager"
mkdir -p "$PACKAGE_DIR/usr/share/applications"
mkdir -p "$PACKAGE_DIR/usr/share/icons/hicolor/256x256/apps"

# Copy DEBIAN metadata files
echo -e "${YELLOW}Copying DEBIAN metadata files...${NC}"

cp .deb/DEBIAN_control "$PACKAGE_DIR/DEBIAN/control"
cp .deb/DEBIAN_postinst "$PACKAGE_DIR/DEBIAN/postinst"
cp .deb/DEBIAN_prerm "$PACKAGE_DIR/DEBIAN/prerm"

# Set permissions on DEBIAN scripts
chmod 755 "$PACKAGE_DIR/DEBIAN/postinst"
chmod 755 "$PACKAGE_DIR/DEBIAN/prerm"
chmod 644 "$PACKAGE_DIR/DEBIAN/control"

# Copy application files
echo -e "${YELLOW}Copying application files...${NC}"

cp -r "$SOURCE_APP_DIR"/* "$PACKAGE_DIR/opt/ABDownloadManager/" 2>/dev/null || true

# Ensure bin directory and binary are executable
if [ -f "$PACKAGE_DIR/opt/ABDownloadManager/bin/ABDownloadManager" ]; then
    chmod 755 "$PACKAGE_DIR/opt/ABDownloadManager/bin/ABDownloadManager"
fi
chmod 755 "$PACKAGE_DIR/opt/ABDownloadManager/bin" 2>/dev/null || true

# Copy desktop file
echo -e "${YELLOW}Copying desktop launcher...${NC}"

cp .deb/abdownloadmanager.desktop "$PACKAGE_DIR/usr/share/applications/"
chmod 644 "$PACKAGE_DIR/usr/share/applications/abdownloadmanager.desktop"

# Copy and install icon
echo -e "${YELLOW}Copying application icon...${NC}"

if [ -f "$SOURCE_APP_DIR/icon.png" ]; then
    cp "$SOURCE_APP_DIR/icon.png" "$PACKAGE_DIR/usr/share/icons/hicolor/256x256/apps/abdownloadmanager.png"
    chmod 644 "$PACKAGE_DIR/usr/share/icons/hicolor/256x256/apps/abdownloadmanager.png"
else
    echo -e "${YELLOW}Warning: Icon file not found at $SOURCE_APP_DIR/icon.png${NC}"
fi

# Build the .deb package
echo -e "${YELLOW}Building .deb package...${NC}"

dpkg-deb --build "$PACKAGE_DIR" "$DEB_FILENAME"

# Verify the package
if [ -f "$DEB_FILENAME" ]; then
    echo -e "${GREEN}✓ Package created successfully: $DEB_FILENAME${NC}"
    echo -e "${YELLOW}Package contents:${NC}"
    dpkg -c "$DEB_FILENAME" | head -20
    echo -e "${YELLOW}...${NC}"
    
    # Display package info
    echo -e "${YELLOW}Package information:${NC}"
    dpkg -I "$DEB_FILENAME"
    
    echo -e "${GREEN}Build completed successfully!${NC}"
    echo -e "${YELLOW}Installation command:${NC}"
    echo -e "  ${GREEN}sudo dpkg -i $DEB_FILENAME${NC}"
else
    echo -e "${RED}Error: Failed to create .deb package${NC}"
    exit 1
fi

# Clean up package directory
rm -rf "$PACKAGE_DIR"

exit 0
