#!/usr/bin/env pwsh
$ErrorActionPreference = "Stop"
$ROOT = Split-Path -Parent $MyInvocation.MyCommand.Path

Write-Host "Starting Legal Search Portal..." -ForegroundColor Cyan

# Start backend
if (Test-Path "$ROOT\backend\.venv\Scripts\Activate.ps1") {
    Write-Host "Starting backend with virtual environment..." -ForegroundColor Yellow
    Start-Process -NoNewWindow -FilePath "pwsh" -ArgumentList "-Command", "cd '$ROOT\backend'; .\.venv\Scripts\Activate.ps1; python -m uvicorn app.main:app --reload --port 8000"
} else {
    Write-Host "Starting backend directly..." -ForegroundColor Yellow
    Start-Process -NoNewWindow -FilePath "uvicorn" -ArgumentList "app.main:app", "--reload", "--port", "8000" -WorkingDirectory "$ROOT\backend"
}

# Start frontend after brief delay
Start-Sleep -Seconds 2
Write-Host "Starting frontend development server..." -ForegroundColor Yellow
Start-Process -NoNewWindow -FilePath "npm" -ArgumentList "run", "dev" -WorkingDirectory "$ROOT\frontend"

Write-Host "✅ Both servers started!" -ForegroundColor Green
Write-Host "Press any key to stop servers..."
$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")