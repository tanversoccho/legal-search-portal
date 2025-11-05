#!/bin/bash

# setup.sh - Setup script for Legal Search Portal
# Runs only environment setup (backend + frontend)
# Usage:
#   chmod +x setup.sh
#   ./setup.sh

root=$(dirname "$0")

echo "====================================="
echo "   Legal Search Portal - Setup Tool  "
echo "====================================="

# ------------------------------
# Backend Setup
# ------------------------------
echo -e "\n[1/2] Setting up backend environment..."
pushd "$root/backend" > /dev/null

# Check for Python 3.11 first, then fall back to available Python 3
if command -v python3.11 &> /dev/null; then
    echo "Creating Python 3.11 virtual environment..."
    python3.11 -m venv .venv
elif command -v python3 &> /dev/null; then
    echo "Creating Python virtual environment using python3..."
    python3 -m venv .venv
else
    echo "ERROR: Python 3 not found! Please install Python 3.11 or later."
    popd > /dev/null
    exit 1
fi

# Activate venv and install dependencies
if [ -f ".venv/bin/activate" ]; then
    echo "Activating virtual environment and installing dependencies..."
    source .venv/bin/activate
    python -m pip install --upgrade pip
    pip install -r requirements.txt
    deactivate
else
    echo "WARNING: .venv activation script not found. Ensure Python is installed properly."
fi

popd > /dev/null

# ------------------------------
# Frontend Setup
# ------------------------------
echo -e "\n[2/2] Installing frontend dependencies..."
pushd "$root/frontend" > /dev/null

if command -v npm &> /dev/null; then
    npm install
else
    echo "WARNING: npm not found! Please install Node.js (https://nodejs.org/) and rerun this script."
fi

popd > /dev/null

echo -e "\n✅ Setup completed successfully!"
echo "To run the project manually:"
echo "  1. Activate backend venv:   cd backend; source .venv/bin/activate"
echo "  2. Start backend:           uvicorn app.main:app --reload --port 8000"
echo "  3. Start frontend:          cd ../frontend; npm run dev"