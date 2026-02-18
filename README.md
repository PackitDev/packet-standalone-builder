# Packet SDK - Standalone Executable Builder

This repository automatically builds standalone executables for Packet SDK using GitHub Actions.

## 🎯 Purpose

- Build cross-platform executables (Windows, macOS, Linux)
- Automated builds on push/tag
- No local build environment needed
- Distribute via GitHub Releases

## 🚀 Quick Start

### 1. Create GitHub Repository

```bash
# Create new repo on GitHub: packet-standalone-builder
# Then:
git init
git add .
git commit -m "Initial commit: Standalone builder setup"
git remote add origin https://github.com/YOUR_USERNAME/packet-standalone-builder.git
git push -u origin main
```

### 2. Add Packet SDK Source

You have two options:

**Option A: Git Submodule (Recommended)**
```bash
git submodule add https://github.com/YOUR_USERNAME/packet-sdk.git source
git submodule update --init --recursive
```

**Option B: Copy Source Files**
```bash
# Copy your Packet SDK source to ./source/
cp -r /path/to/packet-sdk ./source/
```

### 3. Trigger Build

**Option 1: Push a tag**
```bash
git tag v1.0.0-beta.1
git push origin v1.0.0-beta.1
```

**Option 2: Manual trigger**
- Go to Actions tab on GitHub
- Select "Build Standalone Executables"
- Click "Run workflow"
- Enter version number

### 4. Download Executables

- Go to Releases tab
- Download the executables for your platform
- Distribute to users!

## 📦 What Gets Built

- `packet-windows-x64.exe` (~45 MB)
- `packet-macos-x64` (~45 MB)
- `packet-macos-arm64` (~45 MB)
- `packet-linux-x64` (~45 MB)

Plus:
- Installation scripts
- Documentation
- SHA256 checksums
- Distribution packages (.zip/.tar.gz)

## 🔧 Configuration

### Environment Variables

Set these in GitHub repository settings (Settings → Secrets and variables → Actions):

**Optional but recommended:**
- `CODE_SIGN_CERT_WINDOWS` - Windows code signing certificate (base64)
- `CODE_SIGN_CERT_PASSWORD` - Certificate password
- `APPLE_DEVELOPER_ID` - Apple Developer ID for macOS signing
- `AWS_ACCESS_KEY_ID` - For S3 upload (optional)
- `AWS_SECRET_ACCESS_KEY` - For S3 upload (optional)

### Customize Build

Edit `.github/workflows/build.yml`:

```yaml
# Change Node.js version
- uses: actions/setup-node@v4
  with:
    node-version: '20'  # Change from 18 to 20

# Change platforms
targets: [
  'node18-win-x64',
  'node18-win-arm64',  # Add Windows ARM
  # ...
]
```

## 📋 Build Process

1. **Checkout** - Clone source code
2. **Setup** - Install Node.js and pnpm
3. **Build** - Compile TypeScript packages
4. **Bundle** - Create standalone executables with pkg
5. **Test** - Run automated tests
6. **Package** - Create distribution archives
7. **Sign** - Code sign executables (if configured)
8. **Release** - Create GitHub Release with all files
9. **Upload** - Upload to S3/CDN (if configured)

## 🧪 Testing

### Test Locally (Before Pushing)

```bash
# Install dependencies
pnpm install

# Build
pnpm build:standalone

# Test
pnpm test:standalone

# Package
pnpm package:standalone
```

### Test in GitHub Actions

Push to a test branch:
```bash
git checkout -b test-build
git push origin test-build
```

Then manually trigger the workflow.

## 📊 Build Time

- **Per platform:** ~5-10 minutes
- **All platforms (parallel):** ~10-15 minutes
- **Total with packaging:** ~15-20 minutes

## 🔐 Code Signing

### Windows

1. Purchase code signing certificate (~$100-500/year)
2. Convert to base64:
   ```bash
   base64 -i certificate.pfx -o cert.txt
   ```
3. Add to GitHub Secrets:
   - `CODE_SIGN_CERT_WINDOWS` = contents of cert.txt
   - `CODE_SIGN_CERT_PASSWORD` = your password

### macOS

1. Join Apple Developer Program ($99/year)
2. Create Developer ID certificate
3. Add to GitHub Secrets:
   - `APPLE_DEVELOPER_ID` = "Developer ID Application: Your Name (TEAM_ID)"
   - `APPLE_CERT_P12` = base64 encoded .p12 file
   - `APPLE_CERT_PASSWORD` = certificate password

## 📈 Monitoring

### Check Build Status

- Go to Actions tab
- View workflow runs
- Check logs for errors

### Download Artifacts

- Each workflow run creates artifacts
- Available for 90 days
- Download from Actions → Workflow run → Artifacts

## 🐛 Troubleshooting

### Build Fails

**Problem:** `pkg: Cannot find module`
- Check that all dependencies are in package.json
- Verify source code is complete

**Problem:** Out of memory
- Increase runner memory in workflow
- Or build platforms separately

**Problem:** Timeout
- Increase timeout in workflow
- Or split into multiple jobs

### Executables Don't Work

**Problem:** Windows security warning
- Code sign the executable
- Or users click "More info" → "Run anyway"

**Problem:** macOS verification error
- Sign and notarize the executable
- Or users run: `xattr -r -d com.apple.quarantine packet`

## 🎯 Best Practices

1. **Tag releases** - Use semantic versioning (v1.0.0)
2. **Test before release** - Use manual workflow trigger first
3. **Keep source updated** - Update submodule regularly
4. **Monitor builds** - Check Actions tab for failures
5. **Sign executables** - Invest in code signing for trust

## 📚 Documentation

- [Standalone Executables Guide](../docs/STANDALONE_EXECUTABLES.md)
- [Quick Start for Users](../docs/STANDALONE_QUICK_START.md)
- [Implementation Details](../docs/reports/STANDALONE_IMPLEMENTATION.md)

## 🆘 Support

- **Issues:** https://github.com/YOUR_USERNAME/packet-standalone-builder/issues
- **Main Repo:** https://github.com/YOUR_USERNAME/packet-sdk
- **Email:** support@packetsdk.dev

## 📄 License

Same as Packet SDK - Proprietary Licensed Software
© 2026 Packet SDK. All rights reserved.
