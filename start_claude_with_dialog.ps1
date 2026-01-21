Add-Type -AssemblyName System.Windows.Forms

# ========================================
# Claude Code Launcher
# ========================================

# Get script directory
$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path

Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "  Claude Code Launcher" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# Open cheatsheet in browser
$cheatsheetPath = Join-Path $scriptDir "cheatsheet.html"
if (Test-Path $cheatsheetPath) {
    Write-Host "[0/4] Opening cheatsheet..." -ForegroundColor Magenta
    Start-Process $cheatsheetPath
}

# Folder selection dialog
Write-Host "[1/4] Select project folder..." -ForegroundColor Yellow

$folderBrowser = New-Object System.Windows.Forms.FolderBrowserDialog
$folderBrowser.Description = "Select project folder for Claude Code"
$folderBrowser.SelectedPath = [System.Environment]::GetFolderPath("MyDocuments")
$folderBrowser.ShowNewFolderButton = $false

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

# Check Git
Write-Host ""
Write-Host "[2/4] Checking Git status..." -ForegroundColor Yellow

if (Test-Path ".git") {
    Write-Host "  Git repository found" -ForegroundColor Green
} else {
    Write-Host "  No Git repository. Initializing..." -ForegroundColor Cyan
    git init
    Write-Host "  Git repository created" -ForegroundColor Green
}

# Pre-work commit
Write-Host ""
Write-Host "[3/4] Saving current state..." -ForegroundColor Yellow

$timestamp = Get-Date -Format "yyyy-MM-dd HH:mm"
git add .
$commitResult = git commit -m "Pre-work $timestamp" 2>&1

if ($LASTEXITCODE -eq 0) {
    Write-Host "  Commit complete" -ForegroundColor Green
} else {
    Write-Host "  No changes to commit" -ForegroundColor Gray
}

# Launch Claude Code
Write-Host ""
Write-Host "[4/4] Launching Claude Code (Sonnet)..." -ForegroundColor Yellow
Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

claude --model sonnet
