-- Interview Prep : Supabase schema
-- Run this in the Supabase SQL editor (one project, single user).

create table if not exists progress (
  question_id integer primary key,
  status text not null check (status in ('known', 'review')),
  updated_at timestamptz not null default now()
);

create table if not exists sessions (
  id uuid primary key default gen_random_uuid(),
  ts bigint not null,
  domain text not null,
  score integer not null,
  total integer not null,
  created_at timestamptz not null default now()
);

create index if not exists sessions_ts_idx on sessions (ts desc);

alter table progress enable row level security;
alter table sessions enable row level security;

-- Single-user personal project: allow the anon key full access.
-- If you later add auth, replace these with per-user policies.
drop policy if exists "open access" on progress;
create policy "open access" on progress
  for all using (true) with check (true);

drop policy if exists "open access" on sessions;
create policy "open access" on sessions
  for all using (true) with check (true);
