# /weekly-retro — sprint retro prep

Run on the morning of retro day, every two weeks.

## What to produce

A retro doc pre-filled in this exact order:

1. **Sprint dates** — start and end.
2. **Throughput** — items closed, points closed, vs rolling 4-sprint average.
3. **Wall of Wins (suggestions only)** — 2-3 candidate wins from GitHub project #42. Leave space for the team to add their own. Do NOT pre-fill all of it; let the team surface wins themselves.
4. **Do / Don't Do / Want matrix** — empty for the team to fill, but seed each column with one observation from the data:
   - **Do:** a working pattern the data supports (e.g. throughput stable)
   - **Don't Do:** a recurring time sink (e.g. alert fatigue pattern, vendor incident response)
   - **Want:** a capability gap visible in the backlog
5. **Higher-agency problems first.** Surface 1-2 problems where the team has real agency (alert fatigue, runbook coverage) before any vendor-caused incident.
6. **Open from last retro** — commitments from the prior retro and their current state.

## What to do

- Pull GitHub project #42 items closed in the sprint window.
  - Read #42 from the committed snapshot `data/p42.json` in the repo checkout
    (fall back to `~/.claude/data/p42.json` locally); the board is GraphQL-only
    and web sessions cannot reach it live. For throughput numbers, refresh first:
    trigger `refresh-project42.yml` via the GitHub MCP (`actions_run_trigger`,
    method `run_workflow`, ref `main`), wait ~1 min for the snapshot commit on
    main, and pull. If the refresh fails, use the committed snapshot and state
    its commit date rather than estimating.
- Pull #data-alerts (`C033WA4R0SK`) message volume bucketed by category — Segment PROD errors, Orchestrator Flow errors, Hubspot errors. Surface alert fatigue trend if any.
- Pull last retro's commitments from Notion and check status.

## Format rules

- Wall of Wins + retro section = past-focused. Do/Don't Do/Want = forward-looking. Keep them visually distinct.
- Final output goes in Notion. Apply Apify style.
- Three concrete commitments maximum, each with named owner.
- Wins are sparse and selective. The team adds; you do not over-fill.
