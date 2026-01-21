@echo off
chcp 65001 >nul
powershell -ExecutionPolicy Bypass -File "%~dp0switch_mode.ps1"
