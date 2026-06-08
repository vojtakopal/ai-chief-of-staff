# Wire-up — getting the chief-of-staff setup running

The personalised scaffold (`CLAUDE.md`, `goals.yaml`, `commands/`, `contacts/team.yaml`) is already in place. This doc is the remaining wiring.

## What to update before first run

- Resolve the TBDs in `contacts/team.yaml` — roles, current focus, comms style. Jan's GitHub handle is still missing.
- Sanity-check `goals.yaml` weights and goal lists. They were drafted from context, not from stated commitments. Edit anything that does not match.
- Confirm 07:30 Europe/Prague as the right `/gm` time.
- Decide where `/gm` output should land (private Slack channel, log file, or both).

## MCP servers

These are connected in Claude.ai already. For Claude Code, configure them in `~/.claude.json`:

```json
{
  "mcpServers": {
    "notion": { "url": "https://mcp.notion.com/mcp" },
    "slack": { "url": "https://mcp.slack.com/mcp" },
    "gmail": { "url": "https://gmailmcp.googleapis.com/mcp/v1" },
    "calendar": { "url": "https://calendarmcp.googleapis.com/mcp/v1" },
    "github": {
      "url": "https://api.githubcopilot.com/mcp/",
      "headers": { "X-MCP-Toolsets": "all" }
    },
    "snowflake": { "url": "https://yfb47557-keboolaapify.snowflakecomputing.com/api/v2/databases/APIFY_ANALYTICS/schemas/SEMANTIC_VIEWS/mcp-servers/MCP_SERVER" },
    "mixpanel": { "url": "https://mcp.mixpanel.com/mcp" }
  }
}
```

The `X-MCP-Toolsets: all` header on GitHub is the fix learned the hard way. Without it, no project tools.

## Send guardrail (hook)

A `PostToolUse` hook for any irreversible send. Adopt tomochang's pattern from
[tomochang/ai-chief-of-staff](https://github.com/tomochang/ai-chief-of-staff).
At minimum, block on any `slack:send_message` or `gmail:send` until a send checklist is acknowledged.
This backstops the send-approval rule in `CLAUDE.md` at the harness level.

## Headless cron for `/gm`

```
30 7 * * 1-5  cd ~/Projects/apify-chief-of-staff && claude -p "/gm" >> ~/gm.log 2>&1
```

Output can go to a private Slack channel via the Slack MCP, or to a log file you read on your phone.
Test `/gm` interactively first — only schedule via cron once it produces output you'd actually read.

## Slack approval flow (optional)

For autonomous actions: post a preview to a private channel, wait for a thumbs-up reaction, then proceed.

## Next commands to add

Obvious additions once `/gm` runs clean:

- `/triage` — inbox + Slack triage (upstream `commands/triage.md` exists; personalise it)
- `/decision` — frame a decision against `goals.yaml`
- `/weekly-content` — surface 1-2 LinkedIn post angles from the week's real work
- `schedules.yaml` — the starter kit uses this for automation; wire after cron is up

## Reference repos to steal from

- [mimurchison/claude-chief-of-staff](https://github.com/mimurchison/claude-chief-of-staff) — base
- [tomochang/ai-chief-of-staff](https://github.com/tomochang/ai-chief-of-staff) — hook pattern, Slack approval flow
- [garrytan/gstack](https://github.com/garrytan/gstack) — operational leadership commands
