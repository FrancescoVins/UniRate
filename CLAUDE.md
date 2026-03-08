# CLAUDE.md — UniRate Codebase Guide

This file provides context and conventions for AI assistants working on the UniRate codebase.

---

## Project Overview

UniRate is a **static frontend web application** for discovering and reviewing universities worldwide. It is built with plain HTML, CSS, and JavaScript — no framework, no build step. Data is persisted via [Supabase](https://supabase.com/) (PostgreSQL) queried directly from the browser using the Supabase JS client.

**Live deployment target:** Vercel (static hosting).

---

## Repository Structure

```
/UniRate
├── CLAUDE.md               # This file
├── README.md               # Deployment guide and monetization roadmap
├── index-en.html           # Main page: homepage, search, review form, AI chat
├── university.html         # Dynamic university profile (loads via ?name= param)
└── bocconi.html            # Static SEO-optimised page for Bocconi University
```

> Files for harvard.html, luiss.html, and fudan.html are referenced in the codebase but do not yet exist in the repo.

---

## Architecture

```
Browser
  └── index-en.html / university.html / bocconi.html
        └── Supabase JS Client (CDN)
              └── Supabase API → PostgreSQL
```

- **No backend server.** All logic runs client-side.
- **No build pipeline.** Files are deployed as-is.
- **No package manager.** No node_modules, no npm/yarn/pnpm.
- **No test suite.** Testing is manual.
- **External dependencies** are loaded via CDN `<script>` tags only.

---

## Key Files In Detail

### `index-en.html` (~2814 lines)

The main application file. All CSS lives in `<style>` tags (lines 8–1543) and all JavaScript in `<script>` tags (lines 2138–2753). Key features embedded here:

- **University search & filter** — real-time filtering of the featured universities grid by name, location, or quick-filter tags (Italy, USA, UK, Business, Engineering, Medicine).
- **Review modal** — 8-category rating form (overall, teaching quality, facilities, networking, career, plus pros/cons tags). Validates minimum 100 characters for review text. Currently saves to `localStorage` only (not yet sent to Supabase).
- **Onboarding modal** — collects up to 3 user preferences; saves to `localStorage`.
- **AI Assistant chat widget** — right-sidebar chat with a hardcoded knowledge base for 13 universities. Supports queries about MBA programs, tech/engineering, Asia programs, scholarships, costs, placements, and design fields.
- **Language detection** — auto-redirects Italian browsers to the Italian variant.

### `university.html` (~399 lines)

Dynamic university profile page. Reads `?name=` from the URL, queries Supabase `universities` table (case-insensitive `ilike` match), then fetches related `reviews`. Displays overview stats, a review list, and a quick-facts sidebar.

### `bocconi.html` (~697 lines)

A hand-crafted static page for Bocconi University. Hardcoded data and sample reviews for SEO purposes. Same visual structure as `university.html` but no dynamic queries.

---

## Database (Supabase)

**Project URL:** `https://gdtgazxqkbqdg1ejmfjh.supabase.co`

### Tables

#### `universities`
| Column | Type | Notes |
|---|---|---|
| id | uuid / int | Primary key |
| name | text | University name |
| country | text | |
| state_province | text | |
| web_pages | text | |
| rating | numeric | Aggregate rating |
| review_count | int | |
| cost_level | text | |

~9,997 universities total.

#### `reviews`
| Column | Type | Notes |
|---|---|---|
| id | uuid | Primary key |
| university_id | ref → universities | |
| overall_rating | numeric | |
| teaching_quality | numeric | |
| course_content | numeric | |
| career_services | numeric | |
| networking | numeric | |
| facilities | numeric | |
| student_life | numeric | |
| city_lifestyle | numeric | |
| review_text | text | |
| pros | text | |
| cons | text | |
| created_at | timestamp | |

### Supabase Queries Used

```javascript
// university.html — fetch university by name
supabase.from('universities').select('*').ilike('name', `%${uniName}%`).single()

// university.html — fetch reviews for a university
supabase.from('reviews').select('*').eq('university_id', universityId).order('created_at', { ascending: false })
```

### Security Notes

The Supabase public anon key is intentionally embedded in `university.html`. This is normal for client-side Supabase usage; Row Level Security (RLS) should be configured in the Supabase dashboard to restrict write access appropriately.

---

## Design System

### Colors (CSS custom properties on `:root`)

| Variable | Value | Usage |
|---|---|---|
| `--bg-primary` | `#0a0a0a` | Page background |
| `--bg-secondary` | `#1a1a1a` | Card/panel backgrounds |
| `--text-primary` | `#f5f5f5` | Main text |
| `--text-secondary` | `#a0a0a0` | Muted text |
| `--accent` | `#ff6b35` | Primary accent (orange) |
| `--accent-dim` | `#ff8c5f` | Lighter accent |
| `--border` | `#2a2a2a` | Borders |
| `--gold` | `#ffd700` | Star ratings |

### Fonts (Google Fonts, loaded via CDN)

- **Playfair Display** — headings (`font-family: 'Playfair Display', serif`)
- **Work Sans** — body text (`font-family: 'Work Sans', sans-serif`)

### Responsive Breakpoint

- Mobile: `max-width: 768px`
- Grid cards: `auto-fit, minmax(300px, 1fr)`

---

## JavaScript Conventions

- **No modules.** All scripts are inline `<script>` blocks at the bottom of each file.
- **DOM manipulation** via vanilla `document.querySelector` / `getElementById`.
- **Event delegation** used for dynamically-generated content.
- **Template literals** for HTML generation inside JS.
- **Async/await** for Supabase queries and simulated AI responses.
- **localStorage** keys: `userReviews`, `userPreferences`.
- No TypeScript. No linting config. No formatter config.

---

## CSS Conventions

- **BEM-like naming:** `.review-modal-overlay`, `.review-modal-header`, `.uni-card-rating`, etc.
- **State modifier classes:** `.active`, `.selected`, `.scrolled`, `.disabled`.
- All CSS lives inside `<style>` blocks within each HTML file — no external stylesheets.

---

## Development Workflow

### Making Changes

Since there is no build step:

1. Edit the relevant `.html` file directly.
2. Open it in a browser (or use a local dev server, e.g. `python3 -m http.server 8080`).
3. Hard-refresh to see changes.

### Adding a New University Static Page

Follow the pattern of `bocconi.html`:
1. Copy `bocconi.html` and rename it to `<university>.html`.
2. Replace all hardcoded university data and review cards.
3. Update `index-en.html` to link to the new page.

### Adding a Feature to the Homepage

All homepage logic is in `index-en.html`. Changes to:
- **Styling** — edit the `<style>` block at the top.
- **HTML structure** — edit the body markup.
- **Behaviour** — edit the `<script>` block at the bottom.

### Connecting the Review Form to Supabase

Currently, submitted reviews are only saved to `localStorage`. To persist them to Supabase:
1. Load the Supabase client in `index-en.html` (already done in `university.html`).
2. In the review submission handler, replace the `localStorage.setItem` call with a `supabase.from('reviews').insert(...)` call.
3. Map form fields to the `reviews` table schema above.

---

## Deployment

**Platform:** Vercel (static hosting)

1. Push changes to the `master` branch on GitHub (`https://github.com/FrancescoVins/UniRate.git`).
2. Vercel auto-deploys on push (once connected in the Vercel dashboard).
3. No build command needed — set root directory to `/` and leave build command blank.

---

## What Does Not Exist (Yet)

- Automated tests (no testing framework configured)
- CI/CD pipeline (no `.github/workflows/`)
- Environment variable management (credentials are inline)
- A backend/API layer
- User authentication
- Admin dashboard
- Static pages for Harvard, LUISS, Fudan (referenced but missing)
- Review submission to Supabase (form saves to localStorage only)

---

## Roadmap Context

From the README, the planned development phases are:

1. **Phase 1** — Google AdSense monetisation, custom domain, initial 50 reviews
2. **Phase 2** — AI University Advisor premium feature (€9.99/mo), SEO, newsletter
3. **Phase 3** — University advertising platform (€299–999/mo), multi-language expansion (Spanish, French, German)

Keep this roadmap in mind when suggesting architectural changes — the project is intentionally simple now and will grow incrementally.
