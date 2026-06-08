# /gm — morning briefing

Run at 07:30 Europe/Prague before I open my laptop.

## What to produce

A single mobile-readable briefing in this exact order:

1. **TL;DR** — one sentence on the day's shape: heavy / normal / light, and why.
2. **Today's calendar** — meetings only. Flag the 2-3 that need actual prep with `→ prep`.
3. **Overnight signals** — Slack mentions in channels I own (#data, #data-alerts, team DMs) and email threads requiring my response. Aggregate by topic, do not list every message.
4. **Goal drift watch** — if today's calendar allocates more than 30% of working hours to a theme weighted under 20% in `goals.yaml`, flag it.
5. **The one thing** — the single highest-leverage item I should do today, grounded in `goals.yaml` priorities.

## What to do

- Pull calendar events for today (`vojtech.kopal@apify.com`, Europe/Prague timezone).
- Search Slack channels and DMs for unread mentions since 18:00 previous workday.
- Search Gmail inbox for unread threads where I am a direct recipient, since the same cutoff.
- For each 1:1 today, surface the report's recent GitHub activity and last retro commitments in one line.
- Cross-reference everything against `goals.yaml` themes and weights.

## Format rules

- Total length under 300 words.
- No emojis. Sentence case. Hyphens with spaces.
- If everything looks calm, say so plainly. Do not pad.
- End with the one thing. No closing pleasantries.
