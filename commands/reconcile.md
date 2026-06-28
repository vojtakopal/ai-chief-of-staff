# /reconcile — close the loop on open commitments

## Description

The antidote to write-only memory. This command re-checks every open task and
every contact follow-up against the actual channels, flags anywhere the recorded
state contradicts reality, and produces one **open loops** view: what you owe, and
who is waiting on you, sorted by age.

Built because state in this repo (tasks, contact files, goals) is written once and
then trusted forever. Stale state does not just go quiet — it actively misleads (a
task marked "complete, ball with them" when the ball is with you, and the person
has chased twice). Run this on a cadence so that never happens silently.

## Arguments

- (none) / `all` — full reconciliation across tasks + contacts, emit open loops.
- `tasks` — reconcile `my-tasks.yaml` only.
- `contacts` — reconcile contact follow-ups only.
- `loops` — skip re-checking; just print the current open-loops view from files.

## Core principles

1. **Declare inputs and as-of time first.** Every run opens with the current
   date/time (verify with `TZ=Europe/Prague date`) and which channels were actually
   reachable. If an MCP server (Slack, Gmail, Calendar, Notion) is down, say so —
   a partial run must never be mistaken for a complete one.
2. **Evidence or it stays open.** Only mark something resolved when there is
   evidence (a reply sent, a meeting that occurred, a confirmation in-channel).
   Lacking evidence, keep it open and tag `VERIFY`. Never infer completion from
   silence.
3. **Every status change carries its evidence and as-of date** in the notes.
4. **The ball direction is explicit.** For every open item, state whether the ball
   is with Vojta or with someone else. "Waiting on them" and "they're waiting on me"
   are different and must not blur.

## What to do

### 1. Open with a header

```
RECONCILE — as of <YYYY-MM-DD HH:MM Europe/Prague>
Inputs reached: Slack [ok/down], Gmail [ok/down], Calendar [ok/down], Notion [ok/down]
```

If any input is down, note what could not be checked and offer to re-run when it
is back.

### 2. Reconcile tasks (`my-tasks.yaml`)

For each task not already `complete`:
- Find recent evidence in the reachable channels (a reply, a meeting that
  happened, a confirmation, a closed PR/issue).
- Compare to the recorded `status` and `notes`.
- Apply changes with evidence:
  - Point-in-time event whose date has passed (a scheduled call) → `complete`
    with `completed:` date, note outcome or tag `VERIFY` if outcome unknown.
  - Recorded "complete/handled" but evidence contradicts it → reopen, restore the
    correct status and ball direction, explain the correction in notes.
  - Past `due_date`, still open → keep open, tag `OVERDUE`, refresh the note.
  - Blocked on someone with no movement for a long time → flag for a final ping
    or a decision to drop.
- Update `# Last reviewed` date at the top.

### 3. Reconcile contact follow-ups (`contacts/*.md`)

- Read the `Last interaction` / `Follow-up needed` section of each contact.
- For Tier 1/2 contacts and anyone with an open "follow-up needed", check the
  channels for newer activity.
- Where the recorded follow-up is stale or wrong (e.g. "ball is with them" but
  they have since chased), correct it with evidence and the as-of date.
- Apply tier cadence (Tier 1: 14d, Tier 2: 30d, Tier 3: 60d) — same thresholds as
  `/enrich stale`.

### 4. Emit the open-loops view

One ranked list, the deliverable of this command:

```
OPEN LOOPS — you owe (ball with you), oldest first
- [age] <who / what> — <next action> — source: <task id / contact> — [OVERDUE?]

WAITING ON OTHERS (ball with them), oldest first
- [age] <who / what> — chasing since <date> — [stale → ping?]

CONTRADICTIONS FOUND (recorded state was wrong)
- <what was recorded> → <reality> → <correction applied>

VERIFY (resolved on inference, not evidence)
- <item> — what to confirm
```

### 5. Persist and report

- Write corrections back to `my-tasks.yaml` and the contact files.
- Commit with a clear message; do not push anything to external channels.
- Drafting a reply or booking time is a follow-on action — show the draft and wait
  for explicit approval (never send without it).

## Format rules

- TL;DR first, then the open-loops view, then detail.
- Sentence case headings, hyphens with spaces, no emojis.
- Lead with the contradictions and the oldest balls-in-your-court — those are the
  failures this command exists to catch.

## Cadence

Weekly is the floor (pairs with `/enrich stale`). Also worth running at the start of
any week back from time off, when the gap between recorded state and reality is widest.
