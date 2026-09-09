# /midyear — mid-year check-in prep (manager side)

Usage: `/midyear <Name>` — e.g. `/midyear Bára`, `/midyear Kuba`. Manager-side
preparation for a direct report's mid-year check-in: the session plan, the
drafted BambooHR manager assessment, a source map, and a career-ladder read.

Scope: the manager assessment and the 1:1 that follows. NOT the self-assessment
(that is the report's own) and NOT the End-of-Cycle review. The person must be a
direct report in `contacts/team.yaml`.

## What to produce

A single prep pack, in this order:

1. **TL;DR** — the one insight that should shape the session (mobile-readable). Insight-led, not a status recap.
2. **Session plan** — a 60-minute structure for the check-in 1:1.
3. **Manager assessment** — the three BambooHR answers, drafted, ready to paste.
4. **Source map** — every point traced to a dated source, with candor flags.
5. **Ladder read** — their self-rating vs observed level, the calibration, and the one real gap.

Save the pack as a `Mid-year prep - <Name>` subpage under today's Daily Journal
(same find-first / no-duplicate rules as `/gm`). Keep the full, unredacted pack
in chat; save a confidentiality-scrubbed copy (see Confidentiality below).

## What to do

1. **Resolve the person** to a direct report via `contacts/team.yaml` (skip if not a report). Pull:
   - their contact file `contacts/<name>.md`, recent 1:1 notes from Notion, their project #42 items (refresh + read the snapshot per `/1on1`), and recent Slack;
   - their PRIOR performance review from Notion (Team / Performance Reviews) — the baseline the mid-year builds on.
2. **Read Apify's Mid-Year Check-In process page** (Apify Wiki / Performance Management) so the prep matches the real process: three open questions, assessments shared ~a day ahead, a 60-minute slot, and the rule that promotion and comp are rarely part of this meeting — those are deferred to the End-of-Cycle review.
3. **Read their inputs if available** — their self-assessment (BambooHR/Notion) and their updated career ladder (usually a Google Sheet). Read the self-scored competencies and their comments; the report's own words are the most useful signal.
4. **Window discipline — this cycle only (March-August).** Use only this-period evidence for "did well"; do not recycle last-cycle wins. Carry-over growth areas are fine only if current signal confirms them — say so.
5. **Draft the three manager-assessment answers** with the `/performance-review` skill for structure and `vojta-voice` for voice. Register: radical candor — specific, no hedging, no compliment sandwich. Output plain-text bullets (BambooHR answer boxes are plain text — no markdown).
6. **Source every point.** Map each bullet to a dated source (Notion page + date, Slack, #42, the ladder). Flag any point that traces only to the prior cycle and recommend cut or verify. Prefer cutting an unsourced-this-period claim over keeping it.
7. **Ladder read.** Compare their self-rating to what you observe:
   - If they under-rate themselves, show where their real work already meets higher-level descriptors and calibrate up. If they over-rate, do the reverse, with evidence.
   - Name the single genuine gap — ideally one they flagged themselves.
   - Use the ladder's advancement math (no gaps, average above the stated threshold, prior level still met) to keep the promotion conversation honest and pointed at End-of-Cycle. The mid-year agrees which two or three competencies to move from "sometimes" to "consistently"; it does not grant the level.
8. **Session plan (60 min).** Frame it (a check-in and realignment, two-way, not the comp conversation) → their self-assessment first → your assessment and alignment → goals review (progress + reset two goals) → growth direction / ladder with the End-of-Cycle framing → their feedback for you → close on two or three goals and one growth focus.

## Confidentiality

- The written BambooHR answers and any saved or team-visible page must never contain: salary, % to midpoint, promotion or comp decisions, PIP / termination / probation, health, or anything sourced from #offer-*, #apify-team-leaders, or #data-finance. The mid-year sets criteria; the End-of-Cycle review settles level and comp.
- Ladder direction and growth expectations ARE fine to write down. A specific promotion promise is not — defer it explicitly, in writing and in the room, so the report is not left guessing.
- Keep the full, unredacted pack in the chat reply only; the saved Notion page is aggregated or pseudonymized per the `/gm` and `/1on1` scrub rules.

## Format rules

- TL;DR first, insight-led (the non-obvious true thing), not a status recap.
- One strong recommendation, not a menu. Name what would change it.
- Every "did well" and "improve" point carries a this-period source.
- Sentence case, hyphens with spaces, no emojis. Plain-text bullets for the BambooHR answers.
- Manager assessment in `vojta-voice`; the three answers ready to paste.

## Why this shape (learned on the first run, Bára, Sep 2026)

- **This-period discipline matters** — the first draft mixed fresh wins with last-cycle material carried in from the prior review; a sharp report notices. Source-checking caught it.
- **Read the ladder self-assessment before the meeting** — it is the highest-signal input. Bára under-rated herself, which flipped the session from "where you fall short" to "here is the evidence you are already at the next level." Expect either direction.
- **The self-assessment often names the growth area for you** — her lowest-confidence competency (documentation / standards) was exactly the manager-side growth point. Let their words carry it.
