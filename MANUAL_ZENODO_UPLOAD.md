# Manual Zenodo Upload - Simple Method

This is often **easier and more reliable** than the automatic GitHub integration.

## Step 1: Build Your Package

First, create the package source file:

```r
library(devtools)
setwd("/Users/thiru.somasundaram/Library/CloudStorage/OneDrive-DeakinUniversity/NuSea.Lab/Associate Research Fellow/Massloss")

# Build the package
build()

# This creates: Massloss_0.1.0.tar.gz in the parent directory
```

Or from terminal:
```bash
cd "/Users/thiru.somasundaram/Library/CloudStorage/OneDrive-DeakinUniversity/NuSea.Lab/Associate Research Fellow/Massloss"
R CMD build .
```

This creates `Massloss_0.1.0.tar.gz` in the current directory.

## Step 2: Go to Zenodo

1. Go to https://zenodo.org/
2. **Sign in** (or create account if needed)
3. Click **"Upload"** (top right, or go to https://zenodo.org/deposit/new)

## Step 3: Fill in Metadata

### Basic Information Tab

1. **Upload files:**
   - Click "Choose files" or drag and drop
   - Upload `Massloss_0.1.0.tar.gz`

2. **Publication type:** Select **"Software"**

3. **Title:** 
   ```
   Massloss: An R Package for Mass Loss Analysis
   ```

4. **Authors/Creators:**
   - Click "Add creator"
   - **Name:** Soma, Thiru
   - **Affiliation:** Deakin University
   - **ORCID:** 0000-0003-0447-7634 (or search for it)
   - Click "Add creator" again
   - **Name:** Francis, Dave
   - **Affiliation:** Deakin University

5. **Description:**
   ```
   An R package for analyzing mass loss in compositional data. This package provides functions for calculating mass loss percentages and simulating compositional decrements to find optimal matches between initial and final compositional datasets (e.g., protein, lipid, ash, carbohydrate percentages).
   ```

6. **Version:**
   ```
   0.1.0
   ```

7. **Publication date:** Today's date

8. **License:** MIT

### Additional Information Tab

1. **Keywords:** Add these (one per line or comma-separated):
   - R
   - mass loss
   - data analysis
   - statistics
   - R-package
   - compositional data

2. **Communities:** 
   - Search for and add "R-packages" community

3. **Related/Alternate identifiers:**
   - **Identifier:** https://github.com/DrThiruCSomasundaram/Massloss
   - **Relation type:** IsSupplementTo or IsIdenticalTo

### Funding Tab (Optional)
- Skip if not applicable

## Step 4: Review and Publish

1. Review all information
2. Click **"Publish"** (or "Save" if you want to review later)
3. **You'll get a DOI immediately!** (e.g., `10.5281/zenodo.1234567`)

## Step 5: Update Your README

Once you have the DOI, update your README.md:

1. Replace `XXXXXXX` in the badge with your actual number
2. Update the citation with the real DOI

## Advantages of Manual Upload

✅ **No configuration issues** - No need for .zenodo.json or CITATION.cff  
✅ **Immediate DOI** - Get it right away, no waiting  
✅ **Full control** - See exactly what will be published  
✅ **Easy to fix** - Can edit metadata before publishing  
✅ **No GitHub sync issues** - Works independently  

## For Future Versions

When you have a new version:

1. Update version in DESCRIPTION (e.g., 0.1.0 → 0.2.0)
2. Build package: `R CMD build .`
3. Go to Zenodo → Upload → Create new version
4. Link it to your previous upload (Zenodo will ask)
5. Upload new .tar.gz file
6. Update metadata if needed
7. Publish

Each version gets its own DOI, but they're all linked together.

## Quick Reference

```bash
# Build package
R CMD build .

# Upload Massloss_0.1.0.tar.gz to https://zenodo.org/deposit/new
# Fill in metadata
# Publish
# Get DOI
# Update README with DOI
```

That's it! Much simpler than the GitHub integration.
