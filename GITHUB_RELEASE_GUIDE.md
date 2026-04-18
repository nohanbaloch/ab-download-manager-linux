# GitHub Release Guide - How to Publish

##  Publishing to GitHub Releases

### Step-by-Step Instructions

#### 1. **Go to GitHub Releases**
- Navigate to: https://github.com/amir1376/ab-download-manager/releases
- Click the **"New release"** button (top right)

#### 2. **Create New Release**

**Tag Version:**
- Click "Choose a tag" dropdown
- Enter: `v1.8.8-debian-packaging` (or `debian-packaging-v1.8.8`)
- If tag doesn't exist, click "Create new tag" option

**Target Branch:**
- Select: `master` (or the current branch)

**Release Title:**
```
ABDownloadManager Debian Packaging Setup v1.8.8
```

#### 3. **Release Description**

Copy the entire content from `RELEASE_NOTES.md` and paste into the release description field.

**Quick Copy Method:**
```bash
cat RELEASE_NOTES.md | xclip -selection clipboard
# Or on macOS:
cat RELEASE_NOTES.md | pbcopy
# Or just open the file and copy manually
```

#### 4. **Attach Files (Optional)**

If you have built the .deb package:
```bash
./build-deb.sh
# Then attach: abdownloadmanager_1.8.8_amd64.deb
```

**To attach:**
- Drag and drop the `.deb` file into the "Attach binaries" section
- Or click and browse to select the file

#### 5. **Publish Release**

- Check: **This is a pre-release** (optional, uncheck when final)
- Click: **"Publish release"** button

---

##  Release Title & Description Template

### Title (Copy Exactly)
```
ABDownloadManager Debian Packaging Setup v1.8.8
```

### Description (Copy from RELEASE_NOTES.md)
The complete release notes content (~12 KB, well-formatted markdown)

---

##  Release Notes Content Summary

The release notes include:
-  Release overview
-  What's new features
-  Quick start instructions
-  Package specifications
-  Installation guide
-  Customization examples
-  Verification commands
-  Distribution options
-  Troubleshooting guide
-  System requirements
-  Verification checklist
-  Getting started section

---

##  Tag Naming Suggestions

Choose one:
- `v1.8.8-debian-packaging`
- `debian-packaging-v1.8.8`
- `v1.8.8.1-packaging`
- `release/debian-packaging-1.8.8`

**Recommended:** `v1.8.8-debian-packaging`

---

##  Optional: Attach the Built Package

If you've already built the `.deb` package:

```bash
# 1. Build the package (if not already done)
./build-deb.sh

# This creates: abdownloadmanager_1.8.8_amd64.deb

# 2. The file will be in the project root
ls -lh abdownloadmanager_1.8.8_amd64.deb

# 3. In GitHub release form, drag/drop or browse to attach
# Users can then directly download and install:
# sudo dpkg -i abdownloadmanager_1.8.8_amd64.deb
```

---

##  What Appears After Publishing

After publishing, the release will show:
- Release title and tag
- Release notes (formatted markdown)
- Attached binaries (if any)
- Release date and author
- Commit link
- Share/download buttons

Users can:
- Read the full release documentation
- Download the `.deb` file (if attached)
- See all the features and changes
- Link to the release from elsewhere

---

##  Pro Tips

1. **Markdown Preview**: Before publishing, click "Preview" to see how the release notes look
2. **Formulas**: The release notes use GitHub markdown (tables, code blocks, etc.) - they render nicely
3. **Updates**: You can edit the release after publishing if needed
4. **Drafts**: Save as draft first to review before publishing
5. **Versions**: Keep release notes for easy version comparison

---

##  Checklist Before Publishing

- [ ] Tag name decided (e.g., `v1.8.8-debian-packaging`)
- [ ] Target branch selected (master)
- [ ] Release title copied (ABDownloadManager Debian Packaging Setup v1.8.8)
- [ ] Release notes pasted from RELEASE_NOTES.md
- [ ] Pre-release checkbox set appropriately
- [ ] Optional: .deb file attached (if built)
- [ ] Preview looks good
- [ ] Ready to publish

---

##  Files to Include in Documentation

The release references:
- `build-deb.sh` - Build automation
- `DEBIAN_control` - Package metadata
- `DEBIAN_postinst` - Post-install script
- `DEBIAN_prerm` - Pre-remove script
- `abdownloadmanager.desktop` - Desktop launcher
- `RELEASE_NOTES.md` - This release documentation
- `QUICK_START.md` - Quick reference
- `DEB_PACKAGING_GUIDE.md` - Full guide
- `PACKAGING_REFERENCE.md` - Technical details
- etc.

All are available in the project repository.

---

##  Release URL Structure

After publishing, your release will be at:
```
https://github.com/amir1376/ab-download-manager/releases/tag/v1.8.8-debian-packaging
```

You can share this link directly with users!

---

##  Sharing the Release

**Share link:**
```
https://github.com/amir1376/ab-download-manager/releases/tag/v1.8.8-debian-packaging
```

**Direct download link (if .deb attached):**
```
https://github.com/amir1376/ab-download-manager/releases/download/v1.8.8-debian-packaging/abdownloadmanager_1.8.8_amd64.deb
```

---

## ⏱ Time to Complete

- Read this guide: 2 minutes
- Prepare release: 2 minutes
- Publish: 1 minute
- **Total: ~5 minutes**

---

##  If You Need Help

1. **GitHub Help**: https://docs.github.com/en/repositories/releasing-projects-on-github/managing-releases-in-a-repository
2. **Markdown Guide**: https://guides.github.com/features/mastering-markdown/
3. **Release Notes Examples**: Look at other projects' releases

---

##  Next Steps

1. Open the release form: GitHub Releases → New release
2. Enter tag: `v1.8.8-debian-packaging`
3. Enter title: `ABDownloadManager Debian Packaging Setup v1.8.8`
4. Paste release notes from `RELEASE_NOTES.md`
5. Click "Publish release"
6. Done! 

---

**Happy releasing! **
