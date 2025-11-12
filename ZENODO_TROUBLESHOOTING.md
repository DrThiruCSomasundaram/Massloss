# Zenodo Troubleshooting Guide

If your GitHub release failed to create a Zenodo DOI, follow these steps:

## Common Issues and Solutions

### 1. Check Repository Connection

**Verify in Zenodo:**
1. Go to https://zenodo.org/account/settings/github/
2. Make sure your `Massloss` repository is listed
3. Ensure the toggle is **ON** (green/enabled)
4. Check if there are any error messages next to the repository

**If repository is not listed:**
- Click "New" → Authorize GitHub again
- Make sure you grant all necessary permissions
- Refresh the page and check again

### 2. Check Release Tag Format

Zenodo requires specific tag formats:
- ✅ **Correct**: `v0.1.0`, `v1.0.0`, `v0.1.0-beta`
- ❌ **Wrong**: `0.1.0`, `release-0.1.0`, `version-0.1.0`

**Fix:**
- Delete the release on GitHub
- Create a new release with tag starting with `v` (e.g., `v0.1.0`)

### 3. Check .zenodo.json File

The `.zenodo.json` file must be:
- In the repository root
- Valid JSON format
- Present in the release tag

**Verify:**
```bash
# Check if file exists
ls -la .zenodo.json

# Validate JSON (if you have jq installed)
cat .zenodo.json | jq .
```

**Common .zenodo.json issues:**
- Missing required fields
- Invalid JSON syntax
- File not committed to the repository

### 4. Repository Visibility

Zenodo can only access **public repositories** for automatic DOI creation.

**Check:**
- Go to your GitHub repository settings
- Ensure repository is **Public** (not Private)

**If private:**
- Make repository public, OR
- Use manual upload to Zenodo instead

### 5. Wait Time

Zenodo processing can take:
- **5-10 minutes** for automatic processing
- Sometimes up to **30 minutes** during high traffic

**What to do:**
- Wait at least 10 minutes after creating release
- Refresh Zenodo integration page
- Check Zenodo's status page: https://status.zenodo.org/

### 6. Check Zenodo Logs

1. Go to https://zenodo.org/account/settings/github/
2. Click on your repository name
3. Check the "Releases" section
4. Look for error messages or failed status

### 7. Manual Upload Alternative

If automatic integration keeps failing, you can manually upload:

1. **Build your package:**
   ```r
   library(devtools)
   build()  # Creates Massloss_0.1.0.tar.gz
   ```

2. **Go to Zenodo:**
   - https://zenodo.org/deposit/new
   - Choose "Upload" (not "GitHub")
   - Fill in metadata from `.zenodo.json`
   - Upload the `.tar.gz` file
   - Publish to get DOI

### 8. Fix .zenodo.json Issues

Make sure your `.zenodo.json` has all required fields:

```json
{
  "title": "Massloss: An R Package for Mass Loss Analysis",
  "description": "An R package for analyzing mass loss in compositional data...",
  "creators": [
    {
      "name": "Your Full Name",
      "affiliation": "Your Affiliation",
      "orcid": "0000-0000-0000-0000"
    }
  ],
  "keywords": ["R", "mass loss", "data analysis", "statistics", "R-package"],
  "license": {"id": "MIT"},
  "upload_type": "software",
  "access_right": "open",
  "communities": [{"identifier": "r-packages"}],
  "version": "0.1.0",
  "language": "eng"
}
```

### 9. Re-sync Repository

Sometimes re-syncing helps:

1. Go to https://zenodo.org/account/settings/github/
2. Toggle your repository **OFF**
3. Wait 30 seconds
4. Toggle it **ON** again
5. Create a new release

### 10. Check GitHub Webhook

Zenodo uses GitHub webhooks. Check if webhook is active:

1. Go to your GitHub repository
2. Settings → Webhooks
3. Look for `zenodo.org` webhook
4. Should show recent deliveries

**If webhook is missing:**
- Re-enable repository in Zenodo
- This should recreate the webhook

## Step-by-Step Recovery Process

1. **Verify connection:**
   - https://zenodo.org/account/settings/github/
   - Repository is listed and enabled

2. **Check release tag:**
   - Must start with `v` (e.g., `v0.1.0`)
   - Delete and recreate if wrong format

3. **Verify .zenodo.json:**
   - File exists in repository root
   - Valid JSON format
   - Committed to the repository

4. **Check repository visibility:**
   - Must be Public for automatic DOI

5. **Wait and check:**
   - Wait 10-15 minutes
   - Check Zenodo integration page
   - Look for error messages

6. **If still failing:**
   - Try manual upload
   - Or contact Zenodo support: support@zenodo.org

## Quick Diagnostic Commands

```bash
# Check if .zenodo.json exists and is valid
cd "/Users/thiru.somasundaram/Library/CloudStorage/OneDrive-DeakinUniversity/NuSea.Lab/Associate Research Fellow/Massloss"
cat .zenodo.json | python3 -m json.tool

# Check git tags
git tag -l

# Verify file is in repository
git ls-files | grep zenodo
```

## Contact Zenodo Support

If nothing works:
- Email: support@zenodo.org
- Include: Repository URL, release tag, error messages
- They usually respond within 24-48 hours
