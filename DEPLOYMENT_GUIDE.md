# Deployment Guide: GitHub and Zenodo

This guide will walk you through deploying your Massloss R package to GitHub and getting a Zenodo DOI.

## Prerequisites

1. GitHub account
2. Zenodo account (sign up at https://zenodo.org/)
3. Git installed and configured

## Step 1: Prepare the Package

First, make sure your package is ready:

```r
library(devtools)
setwd("path/to/Massloss")

# Generate documentation
document()

# Check the package
check()

# Build the package (optional, for testing)
build()
```

## Step 2: Initialize Git Repository (if not already done)

If you're creating a separate repository for this package:

```bash
cd "/Users/thiru.somasundaram/Library/CloudStorage/OneDrive-DeakinUniversity/NuSea.Lab/Associate Research Fellow/Massloss"

# Initialize git (if not already done)
git init

# Add all files
git add .

# Make initial commit
git commit -m "Initial commit: Massloss R package v0.1.0"
```

## Step 3: Create GitHub Repository

1. Go to https://github.com/new
2. Repository name: `Massloss` (or your preferred name)
3. Description: "R package for analyzing mass loss in compositional data"
4. Choose Public or Private
5. **DO NOT** initialize with README, .gitignore, or license (we already have these)
6. Click "Create repository"

## Step 4: Connect Local Repository to GitHub

After creating the GitHub repository, GitHub will show you commands. Use these:

```bash
cd "/Users/thiru.somasundaram/Library/CloudStorage/OneDrive-DeakinUniversity/NuSea.Lab/Associate Research Fellow/Massloss"

# Add remote
git remote add origin https://github.com/DrThiruCSomasundaram/Massloss.git

# Or if using SSH:
# git remote add origin git@github.com:DrThiruCSomasundaram/Massloss.git

# Push to GitHub
git branch -M main  # or master, depending on your default
git push -u origin main
```

## Step 5: Update Package Metadata

Before deploying, update these files with your information:

1. **DESCRIPTION**: Update author name and email
2. **README.md**: Update GitHub username in URLs
3. **.zenodo.json**: Update with your name, ORCID, and affiliation

## Step 6: Set Up Zenodo Integration

### 6.1 Connect GitHub to Zenodo

1. Go to https://zenodo.org/
2. Sign in (or create account)
3. Go to your account settings: https://zenodo.org/account/settings/github/
4. Click "New" next to GitHub
5. Authorize Zenodo to access your GitHub account
6. Find your `Massloss` repository in the list
7. Toggle it **ON** to enable Zenodo integration

### 6.2 Update .zenodo.json

Edit `.zenodo.json` with your information:

```json
{
  "title": "Massloss: An R Package for Mass Loss Analysis",
  "description": "An R package for analyzing mass loss in compositional data...",
  "creators": [
    {
      "name": "Your Full Name",
      "affiliation": "Your Affiliation",
      "orcid": "0000-0000-0000-0000"  # Get from https://orcid.org/
    }
  ],
  ...
}
```

## Step 7: Create GitHub Release (This Triggers Zenodo DOI)

1. Go to your GitHub repository: `https://github.com/DrThiruCSomasundaram/Massloss`
2. Click "Releases" → "Create a new release"
3. **Tag version**: `v0.1.0` (must start with 'v')
4. **Release title**: `Massloss v0.1.0`
5. **Description**: 
   ```
   Initial release of Massloss package.
   
   Features:
   - Calculate mass loss for compositional data
   - Simulate compositional decrements
   - Find best matching compositions
   ```
6. Click "Publish release"

## Step 8: Get Your Zenodo DOI

1. After creating the release, wait a few minutes
2. Go to https://zenodo.org/account/settings/github/
3. Click on your repository name
4. You should see a new version with a DOI (e.g., `10.5281/zenodo.XXXXXXX`)
5. Click on the version to view/edit metadata if needed

## Step 9: Update README with DOI

Once you have your DOI, update `README.md`:

1. Replace `XXXXXXX` in the badge URL with your actual Zenodo number
2. Update the citation section with the correct DOI

Example:
```markdown
[![DOI](https://zenodo.org/badge/DOI/10.5281/zenodo.1234567.svg)](https://doi.org/10.5281/zenodo.1234567)
```

## Step 10: Push Updates

After updating README with DOI:

```bash
git add README.md
git commit -m "Update README with Zenodo DOI"
git push
```

## Future Releases

For new versions:

1. Update version in `DESCRIPTION` (e.g., `0.1.0` → `0.2.0`)
2. Update version in `.zenodo.json`
3. Commit changes:
   ```bash
   git add DESCRIPTION .zenodo.json
   git commit -m "Bump version to 0.2.0"
   git push
   ```
4. Create new GitHub release with tag `v0.2.0`
5. Zenodo will automatically create a new version with a new DOI

## Troubleshooting

### Zenodo not creating DOI
- Make sure the repository is enabled in Zenodo settings
- Check that the release tag starts with 'v' (e.g., `v0.1.0`)
- Wait a few minutes - it can take 5-10 minutes
- Check Zenodo's GitHub integration status page

### Git push errors
- Make sure you're authenticated: `git config --global user.name` and `git config --global user.email`
- For HTTPS, you may need a personal access token
- For SSH, make sure your SSH key is added to GitHub

### Package check fails
- Run `devtools::check()` locally first
- Fix any errors or warnings
- Make sure all required files are present (DESCRIPTION, NAMESPACE, etc.)

## Quick Reference Commands

```bash
# Navigate to package
cd "/Users/thiru.somasundaram/Library/CloudStorage/OneDrive-DeakinUniversity/NuSea.Lab/Associate Research Fellow/Massloss"

# Check git status
git status

# Add all changes
git add .

# Commit
git commit -m "Your commit message"

# Push to GitHub
git push

# Create a new release (via GitHub web interface)
# Then update version and push again
```

## Next Steps After Deployment

1. Share your package: `devtools::install_github("DrThiruCSomasundaram/Massloss")`
2. Add badges to README (build status, etc.)
3. Consider adding unit tests with `testthat`
4. Add a vignette for detailed usage examples
5. Submit to CRAN (optional, more rigorous process)
