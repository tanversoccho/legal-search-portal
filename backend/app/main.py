from fastapi import FastAPI, HTTPException
from pydantic import BaseModel
from typing import List
from fastapi.middleware.cors import CORSMiddleware
from .docs_data import DOCUMENTS

app = FastAPI(title="Legal Search Mock API")

# Allow local frontend dev origin
app.add_middleware(
    CORSMiddleware,
    allow_origins=["http://localhost:5173", "http://127.0.0.1:5173"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

class Query(BaseModel):
    query: str

class Match(BaseModel):
    doc_id: str
    title: str
    excerpt: str
    summary: str
    score: float

class GenerateResponse(BaseModel):
    query: str
    results: List[Match]


def simple_search_and_summarize(query: str):
    """A basic keyword-matching mock search. Returns matches with an excerpt and short mock summary."""
    q = query.lower().strip()
    results = []
    for doc in DOCUMENTS:
        text_low = doc["text"].lower()
        if q == "":
            # if empty query, return nothing (or you could return suggestions)
            continue
        if q in text_low:
            idx = text_low.find(q)
            start = max(0, idx - 80)
            end = min(len(text_low), idx + 120)
            excerpt = doc["text"][start:end].strip()
            # Create a short 1-2 line summary (mocked)
            summary = "Key points: " + (doc["text"][0:120].strip())
            results.append(
                {
                    "doc_id": doc["id"],
                    "title": doc["title"],
                    "excerpt": excerpt + ("..." if end < len(text_low) else ""),
                    "summary": summary,
                    "score": round(1.0 - (idx / max(1, len(text_low))), 3),
                }
            )
    # sort by score desc
    results.sort(key=lambda r: r["score"], reverse=True)
    return results


@app.post("/generate", response_model=GenerateResponse)
def generate(query: Query):
    if not query.query:
        raise HTTPException(status_code=400, detail="Query must not be empty")
    results = simple_search_and_summarize(query.query)
    return {"query": query.query, "results": results}


# For local debug: uvicorn backend.app.main:app --reload
