#!/usr/bin/env bash
set -e
ROOT="$(cd "$(dirname "$0")" && pwd)"

# Try to start backend using venv if present; support both Unix and Windows venv layouts
if [ -d "$ROOT/backend/.venv" ]; then
  if [ -f "$ROOT/backend/.venv/bin/activate" ]; then
    # Unix-style venv (Linux/macOS)
    ( source "$ROOT/backend/.venv/bin/activate" && cd "$ROOT/backend" && python -m uvicorn app.main:app --reload --port 8000 ) &
  elif [ -f "$ROOT/backend/.venv/Scripts/activate" ]; then
    # Windows-style venv (Git Bash may find this)
    ( source "$ROOT/backend/.venv/Scripts/activate" && cd "$ROOT/backend" && python -m uvicorn app.main:app --reload --port 8000 ) &
  else
    # fallback: try python -m uvicorn without activation
    ( cd "$ROOT/backend" && python -m uvicorn app.main:app --reload --port 8000 ) &
  fi
else
  # no venv, try running uvicorn directly
  ( cd "$ROOT/backend" && uvicorn app.main:app --reload --port 8000 ) &
fi

sleep 1
cd "$ROOT/frontend"
npm run dev
