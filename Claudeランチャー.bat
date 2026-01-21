@echo off
chcp 65001 >nul

:: Check if pywebview is installed
python -c "import webview" 2>nul
if %errorlevel% neq 0 (
    echo [INFO] Installing required library: pywebview...
    pip install pywebview
)

:: Run the launcher
python "%~dp0launcher.py"
