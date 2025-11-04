import React, { useState } from 'react'

export default function App() {
  const [query, setQuery] = useState('')
  const [loading, setLoading] = useState(false)
  const [error, setError] = useState(null)
  const [results, setResults] = useState([])

  async function handleSearch(e) {
    e && e.preventDefault()
    setError(null)
    setResults([])
    if (!query.trim()) {
      setError('Please enter a search query')
      return
    }
    setLoading(true)
    try {
      const res = await fetch('http://localhost:8000/generate', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ query }),
      })
      if (!res.ok) {
        const err = await res.json()
        throw new Error(err.detail || 'Server error')
      }
      const data = await res.json()
      setResults(data.results)
    } catch (err) {
      setError(err.message)
    } finally {
      setLoading(false)
    }
  }

  return (
    <div className="app-root">
      <header className="header">
        <h1>Legal Document Search (Mock)</h1>
        <p className="sub">Search three example legal documents — backend responses are mocked.</p>
      </header>

      <main className="card">
        <form onSubmit={handleSearch} className="query-form">
          <input
            value={query}
            onChange={(e) => setQuery(e.target.value)}
            placeholder="Enter legal term, e.g. 'termination', 'rent', 'non-compete'"
            aria-label="search"
          />
          <button type="submit" disabled={loading}>
            {loading ? 'Searching…' : 'Search'}
          </button>
        </form>

        {error && <div className="error">{error}</div>}

        <section className="results">
          {loading && <div className="loading">Loading results…</div>}

          {!loading && results.length === 0 && !error && (
            <div className="empty">No results yet. Try searching for: <b>termination</b>, <b>rent</b>, <b>warranties</b>.</div>
          )}

          {results.map((r) => (
            <article key={r.doc_id} className="result">
              <h3>{r.title} <span className="badge">{r.doc_id}</span></h3>
              <p className="excerpt">{r.excerpt}</p>
              <p className="summary"><strong>Summary:</strong> {r.summary}</p>
              <div className="meta">Score: {r.score}</div>
            </article>
          ))}
        </section>
      </main>

      <footer className="foot">
        <small>Mock search engine • For demonstration only</small>
      </footer>
    </div>
  )
}
