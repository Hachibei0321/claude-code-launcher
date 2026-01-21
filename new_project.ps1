Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName Microsoft.VisualBasic

# ========================================
# Claude Code - New Project Setup
# ========================================

Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "  Claude Code - New Project Setup" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# Folder selection dialog
Write-Host "[1/3] Select project folder..." -ForegroundColor Yellow

$folderBrowser = New-Object System.Windows.Forms.FolderBrowserDialog
$folderBrowser.Description = "Select folder to initialize for Claude Code"
$folderBrowser.SelectedPath = [System.Environment]::GetFolderPath("MyDocuments")
$folderBrowser.ShowNewFolderButton = $true

$result = $folderBrowser.ShowDialog()

if ($result -ne [System.Windows.Forms.DialogResult]::OK) {
    Write-Host "Cancelled." -ForegroundColor Red
    Read-Host "Press Enter to exit"
    exit
}

$projectPath = $folderBrowser.SelectedPath
Write-Host "  Selected: $projectPath" -ForegroundColor Green

# Change directory
Set-Location -Path $projectPath

# Get project name
Write-Host ""
$projectName = [Microsoft.VisualBasic.Interaction]::InputBox(
    "Enter project name (in Japanese OK):",
    "Project Name",
    (Split-Path $projectPath -Leaf)
)

if ([string]::IsNullOrEmpty($projectName)) {
    $projectName = Split-Path $projectPath -Leaf
}

# Get project description
$projectDesc = [Microsoft.VisualBasic.Interaction]::InputBox(
    "Enter project description:",
    "Project Description",
    ""
)

# Create CLAUDE.md
Write-Host ""
Write-Host "[2/3] Creating CLAUDE.md..." -ForegroundColor Yellow

$claudeMd = @"
# CLAUDE.md - $projectName

## Project Overview

**Project Name**: $projectName
**Description**: $projectDesc
**Created**: $(Get-Date -Format "yyyy-MM-dd")

---

## Communication

- Reply in **Japanese**
- Write code comments in Japanese
- Ask questions if unclear

---

## Coding Style

### Python
- Use type hints
- Add docstrings to functions
- Follow PEP8

### General
- Keep functions small and focused
- Add comments for complex logic
- Handle errors properly

---

## Project Structure

``````
$(Split-Path $projectPath -Leaf)/
+-- (Add your structure here)
``````

---

## Important Notes

- (Add project-specific notes here)

---

## Common Commands

``````bash
# (Add common commands here)
``````
"@

$claudeMd | Out-File -FilePath "CLAUDE.md" -Encoding UTF8
Write-Host "  Created: CLAUDE.md" -ForegroundColor Green

# Initialize Git
Write-Host ""
Write-Host "[3/3] Initializing Git..." -ForegroundColor Yellow

if (-not (Test-Path ".git")) {
    git init
    Write-Host "  Git initialized" -ForegroundColor Green
} else {
    Write-Host "  Git already exists" -ForegroundColor Gray
}

# Initial commit
git add .
git commit -m "Initial commit: Project setup with CLAUDE.md"

Write-Host ""
Write-Host "========================================" -ForegroundColor Green
Write-Host "  Project setup complete!" -ForegroundColor Green
Write-Host "  - CLAUDE.md created" -ForegroundColor Green
Write-Host "  - Git initialized" -ForegroundColor Green
Write-Host "========================================" -ForegroundColor Green
Write-Host ""
Write-Host "You can now run 'Claude Start.bat' to begin!" -ForegroundColor Cyan
Write-Host ""
Read-Host "Press Enter to exit"
