# Quick Zenodo Failure Checklist

Run through these checks if your release failed:

## ✅ Checklist

### 1. Repository Connection
- [ ] Go to https://zenodo.org/account/settings/github/
- [ ] Is your `Massloss` repository listed?
- [ ] Is the toggle **ON** (green/enabled)?
- [ ] Any error messages shown?

**If not connected:**
- Click "New" → Authorize GitHub
- Find `Massloss` → Toggle ON

### 2. Release Tag Format
- [ ] Did you use tag starting with `v`? (e.g., `v0.1.0`)
- [ ] NOT just `0.1.0` or `release-0.1.0`

**Fix:** Delete release, create new one with `v0.1.0`

### 3. Repository Visibility
- [ ] Is your GitHub repository **Public**?
- [ ] Zenodo can only auto-process public repos

**Check:** GitHub repo → Settings → Scroll down to "Danger Zone"

### 4. .zenodo.json File
- [ ] File exists in repository root?
- [ ] File is committed to git?
- [ ] File is in the release tag?

**Check:**
```bash
git ls-files | grep zenodo
git show v0.1.0:.zenodo.json  # Replace v0.1.0 with your tag
```

### 5. Required Fields in .zenodo.json
- [ ] `title` - present and descriptive
- [ ] `description` - present (at least 20 characters)
- [ ] `creators` - at least one creator with name
- [ ] `license` - present
- [ ] `version` - matches release version

### 6. Wait Time
- [ ] Waited at least 10-15 minutes?
- [ ] Checked Zenodo integration page again?

### 7. Check Error Messages
- [ ] Go to https://zenodo.org/account/settings/github/
- [ ] Click on your repository name
- [ ] Check "Releases" section for error messages
- [ ] Look for red X or error icons

## Common Fixes

### Fix 1: Re-sync Repository
1. Go to Zenodo GitHub settings
2. Toggle repository OFF
3. Wait 30 seconds
4. Toggle ON again
5. Create new release

### Fix 2: Update .zenodo.json and Re-release
1. Make sure `.zenodo.json` is committed
2. Update version if needed
3. Push to GitHub
4. Delete old release
5. Create new release with same tag

### Fix 3: Manual Upload (If all else fails)
1. Build package: `devtools::build()`
2. Go to https://zenodo.org/deposit/new
3. Upload the `.tar.gz` file
4. Copy metadata from `.zenodo.json`
5. Publish

## Still Not Working?

1. **Check Zenodo Status:** https://status.zenodo.org/
2. **Contact Support:** support@zenodo.org
   - Include: Repository URL, release tag, screenshots of errors
3. **Try Different Tag:** Sometimes `v0.1.0` works better than `v1.0.0` for first release
