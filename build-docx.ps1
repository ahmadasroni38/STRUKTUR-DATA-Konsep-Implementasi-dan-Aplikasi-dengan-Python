# build-each-docx.ps1
# Usage: Open PowerShell in your book folder and run: .\build-each-docx.ps1
# Requirements: pandoc on PATH. A customized my-reference.docx in the same folder.
# See STYLE_GUIDE.md and SETUP_REFERENCE_DOC.md for how to configure my-reference.docx.

# Config
$outputDir = ".\output"
$referenceDoc = ".\my-reference.docx"   # MUST be customized to match STYLE_GUIDE.md
$resourcePath = ".;image"               # add additional folders separated by semicolon if needed
$toc = $false                           # set $true to add auto-generated TOC (Front Matter already has one)
$tocDepth = 3
$citeproc = $false                      # set $true and provide refs.bib to enable citations
$bibFile = ".\refs.bib"
$luaFilter = ".\filters\callout.lua"    # Lua filter for callout/admonition boxes
$highlightStyle = ".\style\syntax.theme" # custom syntax highlighting theme file

# Ensure pandoc exists
if (-not (Get-Command pandoc -ErrorAction SilentlyContinue)) {
  Write-Error "pandoc not found on PATH. Install pandoc and re-run the script."
  exit 1
}

# Create output directory
if (-not (Test-Path $outputDir)) {
  New-Item -ItemType Directory -Path $outputDir | Out-Null
}

# Verify reference doc exists (do NOT overwrite with default — it should be customized)
if (-not (Test-Path $referenceDoc)) {
  Write-Warning @"
Reference document '$referenceDoc' not found!
  1. Run: pandoc --print-default-data-file reference.docx > my-reference.docx
  2. Open my-reference.docx in Word and customize styles per STYLE_GUIDE.md
  3. See SETUP_REFERENCE_DOC.md for step-by-step instructions.
Continuing with Pandoc defaults...
"@
}

# Build common extra args (use array so spaces are handled)
$extraArgs = @()
$extraArgs += "--resource-path=$resourcePath"
if (Test-Path $referenceDoc) {
  $extraArgs += "--reference-doc=$referenceDoc"
} else {
  Write-Warning "No reference doc found at $referenceDoc. Pandoc will use its defaults."
}
if ($toc) {
  $extraArgs += "--toc"
  $extraArgs += "--toc-depth=$tocDepth"
}
if ($citeproc -and (Test-Path $bibFile)) {
  $extraArgs += "--citeproc"
  $extraArgs += "--bibliography=$bibFile"
}
# Lua filter for callout/admonition boxes
if (Test-Path $luaFilter) {
  $extraArgs += "--lua-filter=$luaFilter"
  Write-Host "Using Lua filter: $luaFilter"
}
# Custom syntax highlighting theme (pandoc 3.8+ uses --syntax-highlighting)
if (Test-Path $highlightStyle) {
  $resolvedTheme = (Resolve-Path $highlightStyle).Path
  $extraArgs += "--syntax-highlighting=$resolvedTheme"
  Write-Host "Using custom highlight style: $resolvedTheme"
}
# standalone option
$extraArgs += "-s"

# Get markdown files (non-recursive). Use -Recurse if you want subfolders.
$mdFiles = Get-ChildItem -Path . -Filter *.md -File

if (-not $mdFiles) {
  Write-Error "No .md files found in current directory."
  exit 1
}

foreach ($f in $mdFiles) {
  $input = $f.FullName
  $outName = Join-Path (Resolve-Path $outputDir) ("{0}.docx" -f $f.BaseName)

  # Build pandoc args as an array so paths with spaces are handled safely
  $pandocArgs = @($input) + $extraArgs + @("-o", $outName)

  Write-Host "Converting: $($f.Name) -> $outName"
  & pandoc @pandocArgs
  $code = $LASTEXITCODE
  if ($code -ne 0) {
    Write-Warning "pandoc failed for $($f.Name) with exit code $code"
  }
}

Write-Host "Done. Converted $($mdFiles.Count) files. Output folder: $outputDir"