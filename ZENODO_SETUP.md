# Setting up Zenodo DOI for Massloss Package

This guide explains how to get a DOI for your package through Zenodo.

## Steps to Create a Zenodo DOI

1. **Create a GitHub Release**
   - Go to your GitHub repository
   - Click on "Releases" → "Create a new release"
   - Tag version: `v0.1.0` (or your version number)
   - Release title: `Massloss v0.1.0`
   - Description: Brief description of the release
   - Click "Publish release"

2. **Connect GitHub to Zenodo**
   - Go to [Zenodo](https://zenodo.org/)
   - Sign up or log in
   - Go to your account settings → GitHub
   - Click "New" next to GitHub
   - Authorize Zenodo to access your GitHub account
   - Select your repository (Massloss)
   - Enable it

3. **Automatic DOI Creation**
   - Zenodo will automatically create a new version/DOI when you create a GitHub release
   - The `.zenodo.json` file in your repository will be used to populate metadata
   - You'll receive a DOI like: `10.5281/zenodo.XXXXXXX`

4. **Update Your README**
   - Replace `XXXXXXX` in the README.md badge with your actual Zenodo DOI number
   - Update the citation section with the correct DOI

5. **Update .zenodo.json**
   - Edit `.zenodo.json` with your actual information:
     - Your name and ORCID
     - Your affiliation
     - Correct version number
     - Any additional keywords

## Manual Upload (Alternative)

If you prefer to upload manually:
1. Go to [Zenodo](https://zenodo.org/)
2. Click "Upload"
3. Fill in the metadata (you can copy from `.zenodo.json`)
4. Upload your package source file (`.tar.gz` created with `R CMD build`)
5. Publish to get a DOI

## Notes

- Each new release on GitHub will create a new version on Zenodo
- The DOI is permanent and can be used in citations
- Make sure to update the README with the actual DOI after the first release
