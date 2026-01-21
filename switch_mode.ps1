Add-Type -AssemblyName System.Windows.Forms

# ========================================
# Claude Code - Mode Switcher
# Switch between Claude (Anthropic) and GLM (Z.AI)
# ========================================

$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$claudeConfigDir = "$env:USERPROFILE\.claude"
$settingsPath = "$claudeConfigDir\settings.json"

$claudeConfig = Join-Path $scriptDir "mode_configs\settings_claude.json"
$glmConfig = Join-Path $scriptDir "mode_configs\settings_glm.json"

Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "  Claude Code - Mode Switcher" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# Check current mode
$currentMode = "Unknown"
if (Test-Path $settingsPath) {
    $currentSettings = Get-Content $settingsPath -Raw | ConvertFrom-Json
    if ($currentSettings.env.ANTHROPIC_BASE_URL -like "*z.ai*") {
        $currentMode = "GLM"
    } else {
        $currentMode = "Claude"
    }
}

Write-Host "Current Mode: " -NoNewline
if ($currentMode -eq "Claude") {
    Write-Host $currentMode -ForegroundColor Green
} elseif ($currentMode -eq "GLM") {
    Write-Host $currentMode -ForegroundColor Magenta
} else {
    Write-Host $currentMode -ForegroundColor Yellow
}
Write-Host ""

# Create form
$form = New-Object System.Windows.Forms.Form
$form.Text = "Claude Code Mode Switcher"
$form.Size = New-Object System.Drawing.Size(350, 200)
$form.StartPosition = "CenterScreen"
$form.FormBorderStyle = "FixedDialog"
$form.MaximizeBox = $false

# Label
$label = New-Object System.Windows.Forms.Label
$label.Text = "Select mode to switch:"
$label.Location = New-Object System.Drawing.Point(20, 20)
$label.Size = New-Object System.Drawing.Size(300, 20)
$form.Controls.Add($label)

# Current mode label
$currentLabel = New-Object System.Windows.Forms.Label
$currentLabel.Text = "Current: $currentMode"
$currentLabel.Location = New-Object System.Drawing.Point(20, 45)
$currentLabel.Size = New-Object System.Drawing.Size(300, 20)
$currentLabel.ForeColor = [System.Drawing.Color]::Gray
$form.Controls.Add($currentLabel)

# Claude button
$claudeBtn = New-Object System.Windows.Forms.Button
$claudeBtn.Text = "Claude (Anthropic)"
$claudeBtn.Location = New-Object System.Drawing.Point(20, 80)
$claudeBtn.Size = New-Object System.Drawing.Size(140, 40)
$claudeBtn.BackColor = [System.Drawing.Color]::FromArgb(76, 175, 80)
$claudeBtn.ForeColor = [System.Drawing.Color]::White
$claudeBtn.FlatStyle = "Flat"
$claudeBtn.Add_Click({
    Copy-Item $claudeConfig $settingsPath -Force
    [System.Windows.Forms.MessageBox]::Show("Switched to Claude (Anthropic) mode!", "Mode Switched", "OK", "Information")
    $form.Close()
})
$form.Controls.Add($claudeBtn)

# GLM button
$glmBtn = New-Object System.Windows.Forms.Button
$glmBtn.Text = "GLM (Z.AI)"
$glmBtn.Location = New-Object System.Drawing.Point(170, 80)
$glmBtn.Size = New-Object System.Drawing.Size(140, 40)
$glmBtn.BackColor = [System.Drawing.Color]::FromArgb(156, 39, 176)
$glmBtn.ForeColor = [System.Drawing.Color]::White
$glmBtn.FlatStyle = "Flat"
$glmBtn.Add_Click({
    # Check if API key is configured
    $glmSettings = Get-Content $glmConfig -Raw
    if ($glmSettings -like "*YOUR_ZAI_API_KEY_HERE*") {
        [System.Windows.Forms.MessageBox]::Show(
            "Please set your Z.AI API key first!`n`nEdit: mode_configs\settings_glm.json`nReplace 'YOUR_ZAI_API_KEY_HERE' with your actual API key.",
            "API Key Required",
            "OK",
            "Warning"
        )
        return
    }
    Copy-Item $glmConfig $settingsPath -Force
    [System.Windows.Forms.MessageBox]::Show("Switched to GLM (Z.AI) mode!", "Mode Switched", "OK", "Information")
    $form.Close()
})
$form.Controls.Add($glmBtn)

# Cancel button
$cancelBtn = New-Object System.Windows.Forms.Button
$cancelBtn.Text = "Cancel"
$cancelBtn.Location = New-Object System.Drawing.Point(125, 130)
$cancelBtn.Size = New-Object System.Drawing.Size(80, 30)
$cancelBtn.Add_Click({ $form.Close() })
$form.Controls.Add($cancelBtn)

# Show form
$form.ShowDialog() | Out-Null

Write-Host ""
Write-Host "Mode switching complete." -ForegroundColor Green
Write-Host "Restart Claude Code for changes to take effect." -ForegroundColor Yellow
Write-Host ""
