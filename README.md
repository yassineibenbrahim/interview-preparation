# Interview Prep

Interactive interview preparation app: 174 questions across 9 domains
(Data Engineering, Python & SQL, ML & Stats, GenAI & LLM, Applied AI,
System Design, Stack, FDE & GTM, HR & Comportemental).

Modes: domain overviews, flashcards, quiz, timed sessions, transversal
knowledge graph. Progress persists locally (localStorage + IndexedDB)
and optionally syncs to Supabase.

## Run

No build step. Serve the folder (or open `index.html`):

```bash
npx serve .
# or
python3 -m http.server
```

Deployed via GitHub Pages from the `main` branch.

## Cloud sync (Supabase, optional)

Without configuration the app works 100% locally: the toolbar badge
shows "local".

1. Create a free project at https://supabase.com
2. In the SQL editor, run `supabase/schema.sql`
3. Project Settings → API: copy the project URL and the `anon` key
4. `cp supabase-config.example.js supabase-config.js` and fill in the values
   (`supabase-config.js` is gitignored)

On next load the app pulls cloud progress/sessions, merges with local
data, pushes local data up, and syncs every grading/session afterwards.
The badge switches to "cloud".

## Data model

- `progress(question_id, status, updated_at)` — per-question status
  (`known` / `review`), upserted on every grading
- `sessions(ts, domain, score, total)` — quiz/session history

The 174 questions live in `index.html` as static data; only user data
goes to the database.

## Security note

RLS is enabled with open policies for the anon key (single-user
personal project). To harden: enable Supabase Auth and scope policies
to `auth.uid()`.
