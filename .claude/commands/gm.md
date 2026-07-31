# /gm — morning briefing

Run at 07:30 Europe/Prague before I open my laptop.

## What to produce

A single mobile-readable briefing, shown in chat and saved to today's Daily Journal (see "Save the briefing to the Daily Journal" below), in this exact order:

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

### Interview auto-prep (when interviews are on today's calendar)

If today's calendar has any interview (organiser is the Talent Acquisition Calendar, or the title contains "Interview" / "Hiring manager" / a candidate name), draft one guide page per interview so I can walk in prepared:

- Parent it under today's Daily Journal page (`Daily YYYY-MM-DD`, database `2edf3995-0a22-80df-8e22-000b259ac157`).
  - MANDATORY, every run, no exceptions: search the database for today's page BEFORE creating anything. A scheduled routine runs /gm at ~07:00 Prague in a separate session, so a page (and even guide pages) may already exist - reuse them, do not recreate. This step was skipped once and produced a duplicate day.
  - Only if no page exists, create one with Title `Daily YYYY-MM-DD` and the Date property set (one page per day), note in the briefing that you created it, and leave Mood/Gratitude/body alone.
  - If you find MORE than one page for today, flag the duplicate in the briefing instead of adding to either.
  - Same dedup applies to guide pages: if a guide for the candidate already exists under today's page, reuse it.
- Title the page `Interview <Candidate>`. Match the existing hiring-manager format (see "Interview Petr", 2026-06-30) exactly - six timed sections: 1) Opening & warm-up, 2) Experience deep-dive, 3) Working style & culture fit (Comfort with ambiguity / Prioritization / Humility & learning), 4) Apify intro & role pitch, 5) Candidate's questions, 6) Wrap-up & next steps - plus a Verdict block to fill after.
- Keep the standard Apify pitch blurb verbatim: "Apify platform & Actors, data complexity (usage-based billing, 19k+ Actors, multiple pricing models), data team (6 → 10+, first data scientist), stack (Snowflake, Keboola, Redash, Mixpanel, Segment, HubSpot), 1/3/6 month milestones."
- Tailor section 2's prompts to the role: Data Engineer → pipelines/orchestration, dbt (incremental, SCD2), Snowflake, ingestion/reverse-ETL, data quality, hiring task = dbt; Data Scientist/Analyst → modelling, experimentation, stakeholder translation, the retention-vs-recurring-revenue framing.
- These are drafts in my own Notion - create them without asking, but do not send anything to the candidate or anyone else. Surface the page link under the meeting in the calendar section with `→ prep (guide drafted)`.

### Save the briefing to the Daily Journal

After producing the briefing, write it into today's Daily Journal page - the same page found or created in the Interview auto-prep step. Reuse it; the find-first and duplicate-page rules there apply verbatim (never create a second page, flag if two exist).

- Write the briefing into the page **body** under a `Morning briefing - HH:MM` (Europe/Prague) heading, keeping the same five sections (TL;DR, calendar, overnight signals, goal drift, the one thing).
- **Formatting - pass real Markdown, never literal escapes.** The content argument must contain actual newlines (real line breaks between sections and one list item per line), NOT the two-character sequence backslash-n, which Notion renders as a literal "n"/"nn". Do not wrap the whole briefing in a single heading or bold run - use a `## Morning briefing - HH:MM` heading, then normal paragraphs and `- ` bullet lines. Do not backslash-escape colons, hyphens, or `>` (write `13:30-14:00`, not `13\:30-14\:00`). If the Notion tool needs multi-line text, provide genuine line breaks in the string.
- Dedup the block: the scheduled ~07:00 run may have already written a morning-briefing block for today. If a `Morning briefing` heading already exists on the page, replace that block's content in place rather than appending a second - one briefing block per day. (If the body contains only the prior briefing, `replace_content` with `new_str` rewrites it cleanly; otherwise target the block with `update_content` old_str/new_str.)
- Leave the structured fields alone: do NOT write into Accomplishments, Tomorrow's Goals, Mood, Gratitude, or Challenges. Accomplishments and Tomorrow's Goals are maintained from the day's work separately; the rest are mine. The briefing lives in the body only.
- **Confidentiality scrub (mandatory).** The journal is more persistent and less private than a chat reply, so the saved copy must never contain sensitive specifics: salary figures, % to midpoint, named compensation nominations, offer numbers, personnel/PIP/termination details, or anything sourced from #apify-team-leaders, #offer-*, or #data-finance. Aggregate or pseudonymize instead - "comp nominations prepped for Product dept", "one L4 report's band review". The full, unredacted briefing stays in the chat reply only.
- Confirm in one line at the end of the chat briefing which Daily Journal page the summary was saved to.

## Format rules

- Total length under 300 words.
- No emojis. Sentence case. Hyphens with spaces.
- If everything looks calm, say so plainly. Do not pad.
- End with the one thing. No closing pleasantries.
