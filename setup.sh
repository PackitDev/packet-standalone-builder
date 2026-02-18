#!/bin/bash

echo "Setting up Packet Standalone Builder..."

# Initialize git if not already
if [ ! -d .git ]; then
  git init
  echo "✓ Git initialized"
fi

# Add all files
git add .

# Initial commit
git commit -m "Initial commit: Standalone builder setup"

echo ""
echo "✓ Setup complete!"
echo ""
echo "Next steps:"
echo "1. Create GitHub repo: https://github.com/new"
echo "2. Run: git remote add origin https://github.com/YOUR_USERNAME/packet-standalone-builder.git"
echo "3. Run: git push -u origin main"
echo "4. Add Packet SDK as submodule:"
echo "   git submodule add https://github.com/YOUR_USERNAME/packet-sdk.git source"
echo "5. Push tag to trigger build:"
echo "   git tag v1.0.0-beta.1"
echo "   git push origin v1.0.0-beta.1"
