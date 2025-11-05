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

Here's your updated setup instructions that simplify the process:

# Legal Document Search Portal — Full Stack Assignment

## Quick Setup (One-Command Installation)

### For Windows:
```powershell
# Clone and setup with one command
git clone https://github.com/tanversoccho/legal-search-portal.git
cd legal-search-portal
.\setup.ps1
```

## After Setup - Run Development Server

Once the setup completes, run:
```bash
./run-dev.sh
```

Then open your browser and go to: **http://localhost:5173**

---

## What the setup script does:

The `setup.ps1` script automates all the manual steps:

1. **Backend Setup**
   - Creates Python virtual environment
   - Installs all backend dependencies
   - Sets up FastAPI with all required packages

2. **Frontend Setup**
   - Installs Node.js dependencies
   - Configures React frontend
   - Sets up Vite development server

3. **Environment Configuration**
   - Ensures proper ports (Frontend: 5173, Backend: 8000)
   - Configures API endpoints
   - Sets up development environment

---

## Manual Setup (Alternative)

If you prefer manual setup, follow these steps:

### 1. Clone Repository
```bash
git clone https://github.com/yourusername/legal-search-portal.git
cd legal-search-portal
```

### 2. Backend Setup
```bash
cd backend
python -m venv .venv
source .venv/bin/activate  # On Windows: .venv\Scripts\activate
pip install -r requirements.txt
```

### 3. Frontend Setup
```bash
cd ../frontend
npm install
```

### 4. Run Development
```bash
cd ..
./run-dev.sh
```

### 5. View Application
Open **http://localhost:5173** in your browser

---

## Scripts Summary


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
[GitHub](https://github.com/tanversoccho) | [LinkedIn](https://www.linkedin.com/in/tanver-rahman-99a8b8208/)
