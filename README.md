# Legal Document Search Portal — Full Stack Assignment

## Overview

The **Legal Document Search Portal** is a full-stack web application designed to allow users to search, view, and manage legal documents efficiently. The project demonstrates frontend-backend integration, API design, and full-stack development best practices using modern web technologies.

---

## Features

* Search legal documents by keywords or categories.
* Display search results dynamically with mocked backend responses.
* Simple and clean UI built with Vite + React.
* Backend powered by FastAPI with Python.
* Ready for deployment with environment-based configuration.

---

## Tech Stack

### Frontend

* **Framework:** React (with Vite)
* **Language:** JavaScript (ES6+)
* **Package Manager:** npm
* **Dev Server:** Vite

### Backend

* **Framework:** FastAPI (Python)
* **Runtime:** Python 3.11
* **Dependencies:** Pydantic, Uvicorn, FastAPI, etc.

### Tools & Environment

* **Node.js** v18+ (for npm)
* **Python** 3.11 (recommended)
* **PowerShell / Git Bash** (for running scripts)

---

## Folder Structure

```
legal-search-portal/
│
├── backend/                  # FastAPI backend
│   ├── app/
│   │   ├── main.py           # FastAPI entry point
│   │   ├── models.py         # Pydantic models
│   │   ├── routes.py         # API routes
│   │   └── ...
│   ├── requirements.txt      # Backend dependencies
│   ├── Dockerfile            # Dockerfile for Backend
│   └── .venv/                # Python virtual environment
│
├── frontend/                 # React frontend (Vite)
│   ├── src/
│   │   ├── App.jsx           # Main React component
│   │   ├── Main.jsx          # UI components
│   │   └── style.css
│   ├── package.json          # npm configuration
│   ├── Index.html           
│   └── vite.config.js        # Vite configuration
│
├── docker-compose.yml
├── run-dev.sh                # Unix dev startup script
└── README.md                 # Project documentation
```

---

## Setup Instructions

### 1. Clone the repository

```bash
git clone https://github.com/yourusername/legal-search-portal.git
cd legal-search-portal
```

### 2. Backend setup (FastAPI)

```powershell
cd backend
py -3.11 -m venv .venv
.\.venv\Scripts\Activate
pip install -r requirements.txt
```

### 3. Frontend setup (React)

```powershell
cd ..\frontend
npm install
```

---

## Running the Project

### Option A — **Run manually (recommended for Windows)**

#### Backend

```powershell
cd backend
.\.venv\Scripts\Activate
uvicorn app.main:app --reload --port 8000
```

#### Frontend

```powershell
cd frontend
npm run dev
```

Then open: [http://localhost:5173](http://localhost:5173)

### Option B — **Run via PowerShell script**

In project root:

```powershell
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope Process -Force
.\run-dev.ps1
```

This will open two PowerShell windows — one for backend and one for frontend.

### Option C — **Run via Bash script (Linux/Mac/WSL)**

```bash
chmod +x run-dev.sh
./run-dev.sh
```

---

## Scripts Summary

### `run-dev.ps1`

* Windows PowerShell script.
* Opens backend and frontend in separate windows.

### `run-dev.sh`

* Bash script for Linux/Mac/WSL.
* Starts backend (with venv auto-detect) and frontend sequentially.

---

## API Overview

**GET** `/api/search?q=<query>`

* Description: Search mock legal documents.
* Response: List of matching documents.

Example response:

```json
[
  {
    "id": 1,
    "title": "Contract Agreement",
    "content": "This agreement is made between..."
  }
]
```

---

## Development Notes

* Always activate the backend venv before installing or running Python code.
* Use `python -m uvicorn app.main:app --reload --port 8000` instead of bare `uvicorn` for consistency.
* Frontend runs on port **5173**, backend on **8000**.

---

## License

This project is for educational and testing purposes only.

---

## Author

**MD. Tanver Rahman Soccho**
Software Engineer | AIUB Graduate
[GitHub](https://github.com/) | [LinkedIn](https://linkedin.com/)
