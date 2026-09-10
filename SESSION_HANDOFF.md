# Session handoff - 2026-09-10

Transient working state to resume a session. The mid-year assessment drafts are
personnel content and are NOT stored here - they live in Notion (links below).
Delete this file once its open threads are closed.

## Already committed to the repo (no action needed)

- `.claude/commands/gm.md` - journal write of the briefing, 1:1 auto-prep, and the "Recent Notion activity" proxy scan (section 3b) via `notion-list-recent-pages` with `page_last_edited_at` verification (7-day window, chat-only, not saved to the journal).
- `.claude/commands/midyear.md` - NEW `/midyear <Name>` command (manager-side mid-year prep). Generalizes the Bára workflow; listed in `CLAUDE.md`.
- `.claude/commands/1on1.md`, `weekly-retro.md` - on-demand #42 refresh via the Actions workflow.
- `contacts/jana-barkova.md` - NEW. Jana Barková, Senior Data Engineer I, direct report, GitHub `janabarkova`. Added to `contacts/team.yaml`, so `/gm` now auto-preps her 1:1s.
- Last commit before this handoff: `fccdaa6` (midyear). Pushed to `main` and `claude/optimistic-bell-6A7Rx`.

## Mid-year check-ins - in progress (drafts in Notion, not git)

Apify process (Notion `29bf3995-0a22-8015-89ec-d2e74a425fc7`): self + manager assessment
in BambooHR, three questions, shared ~a day ahead, 60-min 1:1. Promotion/comp deferred to
End-of-Cycle - mid-year only sets criteria. Cycle window: March-August 2026.

- **Bára** - FINAL manager assessment, ready to paste into BambooHR: https://app.notion.com/p/3d7f39950a22813e8abdd01a5e1e3b54
  - Case: L4 under-rating herself; does L5-level platform work. Growth: load + make long-term work visible (she flagged the documentation/standards competency herself). Ladder read complete.
- **Matej** - DRAFT, meeting Sep 10 (today): https://app.notion.com/p/3d7f39950a228142bf7ccbf951266606
  - Case: L3 on a realistic path to L4. Growth: proactive communication + insights-to-narratives. INCOMPLETE: his current self-assessment + updated ladder are missing, so the ladder read (over/under-rater) is unfinished.

## Open action items

1. **Matej mid-year is TODAY (Sep 10).** Confirm the slot (his ask, unanswered ~1 week); get his self-assessment + updated ladder; finish the ladder read. A one-line Slack to lock the slot was drafted but NOT sent (nothing sent without explicit approval).
2. Remaining reports still need mid-year prep via `/midyear`: Kuba, Markéta, Martina, Tom, Terka (back ~Sep 9), Zuzka, Jana (new/probation - check whether a mid-year even applies).
3. Long-standing: Daniel Večeřa (founder-sourced DS candidate, met 28 Jul) still has no contact file; the meeting outcome was never captured.

## Key facts / decisions this session

- Jana Barková: GitHub `janabarkova`, in `apify/data`; now in team.yaml so `/gm` auto-preps her.
- `/gm` "Recent Notion activity" scan verifies last-edited timestamps before surfacing (recently-viewed is ranked by frequency too; live-test ratio ~1 real signal to ~15 stale).
- `/midyear` pattern learned: this-period-only evidence discipline; read the report's ladder self-assessment before the meeting (highest-signal input, direction varies); the self-assessment often names the growth area itself.
- Sprint 17 started Mon Sep 7 (planned Thu Sep 3). Weekly data sync Mondays 10:00.
- p42 snapshot current as of 2026-09-07.
- Committing personnel/performance content to git is blocked by the auto-mode classifier - keep mid-year drafts in Notion, not the repo.
