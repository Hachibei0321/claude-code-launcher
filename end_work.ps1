Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName Microsoft.VisualBasic

# ========================================
# Claude Code - End of Work Script
# ========================================

Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "  Claude Code - End of Work" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# Folder selection dialog
Write-Host "[1/3] Select project folder..." -ForegroundColor Yellow

$folderBrowser = New-Object System.Windows.Forms.FolderBrowserDialog
$folderBrowser.Description = "Select project folder to commit"
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
if (-not (Test-Path ".git")) {
    Write-Host "  No Git repository found!" -ForegroundColor Red
    Read-Host "Press Enter to exit"
    exit
}

# Show changes
Write-Host ""
Write-Host "[2/3] Changes to commit:" -ForegroundColor Yellow
git status --short

# Get commit message
Write-Host ""
$commitMessage = [Microsoft.VisualBasic.Interaction]::InputBox(
    "Enter commit message:",
    "Commit Message",
    "Work completed " + (Get-Date -Format "yyyy-MM-dd HH:mm")
)

if ([string]::IsNullOrEmpty($commitMessage)) {
    Write-Host "Cancelled." -ForegroundColor Red
    Read-Host "Press Enter to exit"
    exit
}

# Commit
Write-Host ""
Write-Host "[3/3] Committing changes..." -ForegroundColor Yellow

git add .
git commit -m $commitMessage

if ($LASTEXITCODE -eq 0) {
    Write-Host ""
    Write-Host "========================================" -ForegroundColor Green
    Write-Host "  Commit complete!" -ForegroundColor Green
    Write-Host "  Message: $commitMessage" -ForegroundColor Green
    Write-Host "========================================" -ForegroundColor Green
} else {
    Write-Host "  No changes to commit" -ForegroundColor Gray
}

Write-Host ""
Read-Host "Press Enter to exit"
