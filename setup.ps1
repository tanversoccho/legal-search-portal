# setup.ps1 — Setup script for Legal Search Portal
# Runs only environment setup (backend + frontend)
# Usage:
#   Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope Process -Force
#   .\setup.ps1

$root = Split-Path -Parent $MyInvocation.MyCommand.Path

Write-Host "====================================="
Write-Host "   Legal Search Portal - Setup Tool  "
Write-Host "=====================================" -ForegroundColor Cyan

# ------------------------------
# Backend Setup
# ------------------------------
Write-Host "`n[1/2] Setting up backend environment..." -ForegroundColor Yellow
Push-Location "$root\backend"

# Use py launcher if available (Python 3.11 preferred)
if (Get-Command py -ErrorAction SilentlyContinue) {
    Write-Host "Creating Python 3.11 virtual environment..." -ForegroundColor Cyan
    py -3.11 -m venv .venv
} else {
    Write-Host "Creating Python virtual environment using default python..." -ForegroundColor Cyan
    python -m venv .venv
}

# Activate venv and install dependencies
if (Test-Path ".\.venv\Scripts\Activate") {
    Write-Host "Activating virtual environment and installing dependencies..." -ForegroundColor Green
    . .\.venv\Scripts\Activate
    python -m pip install --upgrade pip
    pip install -r requirements.txt
} else {
    Write-Warning ".venv activation script not found. Ensure Python is installed properly."
}

Pop-Location

# ------------------------------
# Frontend Setup
# ------------------------------
Write-Host "`n[2/2] Installing frontend dependencies..." -ForegroundColor Yellow
Push-Location "$root\frontend"

if (Get-Command npm -ErrorAction SilentlyContinue) {
    npm install
} else {
    Write-Warning "npm not found! Please install Node.js (https://nodejs.org/) and rerun this script."
}

Pop-Location

Write-Host "`n✅ Setup completed successfully!"
Write-Host "To run the project manually:"
Write-Host "  1. Activate backend venv:   cd backend; .venv\\Scripts\\Activate"
Write-Host "  2. Start backend:           uvicorn app.main:app --reload --port 8000"
Write-Host "  3. Start frontend:          cd ../frontend; npm run dev"
