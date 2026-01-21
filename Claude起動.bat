@echo off
chcp 65001 >nul
REM ダブルクリック用ランチャー（エラー時も閉じない）
powershell -ExecutionPolicy Bypass -File "%~dp0start_claude_with_dialog.ps1"
if errorlevel 1 (
    echo.
    echo エラーが発生しました。
    pause
)
pause
