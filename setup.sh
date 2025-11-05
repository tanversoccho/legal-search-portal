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

# Check specifically for Python 3.11
echo "Checking for Python 3.11..."
if command -v python3.11 &> /dev/null; then
    echo "✓ Python 3.11 found"
    PYTHON_CMD="python3.11"
elif command -v python3 &> /dev/null; then
    # Check if python3 is actually 3.11
    PYTHON_VERSION=$(python3 --version 2>&1 | cut -d' ' -f2)
    if [[ $PYTHON_VERSION == 3.11* ]]; then
        echo "✓ Python 3.11 found (via python3)"
        PYTHON_CMD="python3"
    else
        echo "❌ ERROR: Python 3.11 required but found $PYTHON_VERSION"
        echo "Please install Python 3.11 and ensure it's available as python3.11 or python3"
        echo "You can download it from: https://www.python.org/downloads/release/python-3119/"
        popd > /dev/null
        exit 1
    fi
else
    echo "❌ ERROR: Python 3.11 not found!"
    echo "Please install Python 3.11 from: https://www.python.org/downloads/release/python-3119/"
    popd > /dev/null
    exit 1
fi

# Verify the exact version one more time before creating venv
FINAL_VERSION=$($PYTHON_CMD --version 2>&1)
if [[ $FINAL_VERSION != *"3.11"* ]]; then
    echo "❌ ERROR: Expected Python 3.11 but found: $FINAL_VERSION"
    echo "Please install Python 3.11 and ensure it's available as python3.11"
    popd > /dev/null
    exit 1
fi

echo "Creating Python 3.11 virtual environment using $PYTHON_CMD..."
$PYTHON_CMD -m venv .venv

# Activate venv and install dependencies
if [ -f ".venv/bin/activate" ]; then
    echo "Activating virtual environment (Linux/Mac) and installing dependencies..."
    source .venv/bin/activate
    python -m pip install --upgrade pip
    pip install -r requirements.txt
    deactivate
elif [ -f ".venv/Scripts/activate" ]; then
    echo "Activating virtual environment (Windows) and installing dependencies..."
    source .venv/Scripts/activate
    python -m pip install --upgrade pip
    pip install -r requirements.txt
    deactivate
else
    echo "WARNING: .venv activation script not found. Ensure Python is installed properly."
    echo "Looking for activation scripts in:"
    find .venv -name "activate" -type f 2>/dev/null || echo "No activate scripts found"
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
echo "  1. Activate backend venv:   cd backend; source .venv/bin/activate (Linux/Mac) OR .venv\Scripts\activate (Windows)"
echo "  2. Start backend:           uvicorn app.main:app --reload --port 8000"
echo "  3. Start frontend:          cd ../frontend; npm run dev"