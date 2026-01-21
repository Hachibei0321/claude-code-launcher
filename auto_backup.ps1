# ========================================
# Claude Code - Auto Backup Script
# Commits and pushes all Git projects
# ========================================

param(
    [string]$BackupFolder = [System.Environment]::GetFolderPath("MyDocuments")
)

$timestamp = Get-Date -Format "yyyy-MM-dd HH:mm"
$logFile = "$env:USERPROFILE\.claude\backup_log.txt"

# Create log directory if not exists
$logDir = Split-Path $logFile -Parent
if (-not (Test-Path $logDir)) {
    New-Item -ItemType Directory -Path $logDir -Force | Out-Null
}

# Log function
function Write-Log {
    param([string]$Message)
    $logMessage = "[$timestamp] $Message"
    Add-Content -Path $logFile -Value $logMessage
    Write-Host $logMessage
}

Write-Log "=========================================="
Write-Log "Auto Backup Started"
Write-Log "Scanning: $BackupFolder"
Write-Log "=========================================="

# Find all Git repositories
$gitRepos = Get-ChildItem -Path $BackupFolder -Directory -Recurse -ErrorAction SilentlyContinue | 
    Where-Object { Test-Path (Join-Path $_.FullName ".git") }

$successCount = 0
$skipCount = 0
$errorCount = 0

foreach ($repo in $gitRepos) {
    $repoPath = $repo.FullName
    $repoName = $repo.Name
    
    try {
        Set-Location -Path $repoPath
        
        # Check if there are changes
        $status = git status --porcelain 2>&1
        
        if ([string]::IsNullOrEmpty($status)) {
            Write-Log "[$repoName] No changes - skipped"
            $skipCount++
            continue
        }
        
        # Commit changes
        git add .
        $commitResult = git commit -m "Auto backup: $timestamp" 2>&1
        
        if ($LASTEXITCODE -ne 0) {
            Write-Log "[$repoName] Commit failed"
            $errorCount++
            continue
        }
        
        # Check if remote exists
        $remotes = git remote 2>&1
        
        if (-not [string]::IsNullOrEmpty($remotes)) {
            # Push to remote
            $pushResult = git push 2>&1
            
            if ($LASTEXITCODE -eq 0) {
                Write-Log "[$repoName] Committed and pushed successfully"
                $successCount++
            } else {
                Write-Log "[$repoName] Committed but push failed"
                $errorCount++
            }
        } else {
            Write-Log "[$repoName] Committed (no remote configured)"
            $successCount++
        }
        
    } catch {
        Write-Log "[$repoName] Error: $_"
        $errorCount++
    }
}

Write-Log "=========================================="
Write-Log "Backup Complete!"
Write-Log "Success: $successCount, Skipped: $skipCount, Errors: $errorCount"
Write-Log "=========================================="
