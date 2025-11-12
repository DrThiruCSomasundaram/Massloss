#!/bin/bash
# Quick setup script for GitHub deployment

cd "/Users/thiru.somasundaram/Library/CloudStorage/OneDrive-DeakinUniversity/NuSea.Lab/Associate Research Fellow/Massloss"

echo "=== Setting up Git for Massloss package ==="
echo ""

# Check if git is initialized
if [ ! -d ".git" ]; then
    echo "Initializing git repository..."
    git init
    echo "✓ Git initialized"
else
    echo "✓ Git already initialized"
fi

# Add all files
echo ""
echo "Adding files to git..."
git add .

# Show status
echo ""
echo "Files to be committed:"
git status --short

echo ""
echo "=== Next Steps ==="
echo ""
echo "1. Review the files above"
echo "2. Commit with: git commit -m 'Initial commit: Massloss R package v0.1.0'"
echo "3. Create a GitHub repository at https://github.com/new"
echo "4. Connect with: git remote add origin https://github.com/DrThiruCSomasundaram/Massloss.git"
echo "5. Push with: git push -u origin main"
echo ""
echo "See DEPLOYMENT_GUIDE.md for detailed instructions!"
