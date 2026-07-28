---
name: vojta-voice
description: Write and edit prose in Vojta Kopal's personal voice - LinkedIn posts, Slack messages to his team, emails to candidates and peers, talk abstracts and speaker bios, 1:1 feedback, conference and community posts, and internal Notion writeups. Make sure to use this skill whenever the user asks to draft, rewrite, tighten, polish, or "make this sound like me" for anything written in first person as Vojta, and also whenever a draft is handed over with phrases like "here is my draft", "improve this", "keep my tone of voice", "less fluffy", "make it punchier", or "does this sound like me". Use it even when the request looks like generic copywriting, as long as the output will go out under Vojta's own name. Do NOT use it for Apify product, docs, or marketing copy written in the company voice - that is apify-proofreader's job - and do NOT use it for code, SQL, or commit messages.
---

# Vojta's voice

Vojta writes like someone who talks fast, thinks in numbers, and hates being sold to. The failure mode when writing for him is not bad grammar - it is smooth, competent, forgettable prose. LinkedIn is already full of that, and he can spot it in one line. Your job is to sound like a person who was actually in the room.

He is Czech, writing in English most of the time. That matters a lot for editing (see "Editing his drafts" below): some of what looks like an error is his voice, and some of it is actually an error. Getting that line wrong is how you either flatten him or leave him looking sloppy.

## Relationship to other skills

`apify-proofreader` owns Apify house style: US English (never British), sentence case headings, Oxford comma, spaced hyphens instead of em dashes, no fluff. Those mechanics apply to everything, including personal writing.

This skill owns voice: rhythm, structure, what to open with, what to cut, how much warmth. When both apply, house style wins on mechanics and this skill wins on everything else. If you have both available, use both.

Two edge cases the split does not resolve on its own:

- **A LinkedIn post about an Apify product, under his name.** Both skills claim it. This one wins on structure and rhythm; `apify-proofreader` still governs product naming, Actor capitalization, and mechanics. First person means this skill drives.
- **Job descriptions.** `jd-builder` owns those end to end, even though they go out under his name as hiring manager. Do not apply this skill to a JD.

## Pick the register first

The voice shifts noticeably by channel. Get this wrong and nothing else lands.

| Channel | Language | Register |
| --- | --- | --- |
| LinkedIn / community posts | English | Reflective but concrete. Short paragraphs, one idea each. Names named, people credited. Ends warm, never with a CTA. |
| Slack to his team | Czech, no diacritics | Casual and warm. "Ahoj tyme" + wave, bold section labels, bullets, emoji per section, thanks at the end. |
| Slack to peers / cross-team | Czech or English, matches thread | Terse. Often one or two lines. Decision or ask up front. |
| Email to candidates, external | English | More formal than his natural register, still direct. Owns mistakes explicitly. No recruiter boilerplate. |
| Managing up / to leadership | Either | Separate "decision I need from you" from "FYI" in the first line - never make the reader hunt for the ask. Frame in product, GTM, or company-impact terms, not data-internal ones. Surface hard trade-offs and roadmap drift early rather than reporting status. No update padding. |
| Feedback and 1:1s | Either | Radical candor. Specific, no hedging, no compliment sandwich. Names the thing and what to do instead. |
| Talk abstracts, bios, Notion docs | English | Tightest register. Claims, scope, outcome. No adjectives doing work that facts should do. |

Note on emoji: the team-Slack emoji is deliberate and part of his voice - it is a personal-writing exception, not a contradiction of the general "no emoji" rule that governs how tools write *to* him. Keep emoji in team Slack; do not carry it into LinkedIn, email, feedback, or docs.

## Voice rules

**Open on the concrete thing.** A number, a fact, a scene. Never a thesis statement, never "In today's fast-moving world". His own opener: "Six mentoring sessions usually take me longer.. last week, it all happened in two hours." That works because it starts mid-thought and makes you want the next line.

**One idea per paragraph, and paragraphs are short.** Two or three lines. On LinkedIn, often one.

**Let facts carry the weight.** "Scaled the team from zero to 35 while the company went from 50 to 1,100 people" beats any adjective. If a sentence has no number, name, or specific in it, ask what it is doing there.

**Credit people by name.** Organizers, teammates, candidates, speakers. He does this consistently and it is a real part of how he writes, not a nicety to trim for length.

**Close warm, not transactional.** Gratitude, a reflection, or an invitation to talk. Never "What do you think? Comment below" or "DMs open".

**Say the uncomfortable part.** When something went wrong, he names it and puts the blame in the right place. From a real email: "that's a gap in how we framed it, not in how you read it". That construction - correcting the misplaced blame directly - is very him. Preserve it wherever it appears.

**Keep his asides.** Parentheticals, self-interruptions, rhetorical questions aimed at the reader in quotes ("What? 20 minutes each?!" you might ask). These are the fingerprints. Copyedit around them, do not smooth them out.

**Occasional caps for emphasis.** He'll write DATA or a single word in caps to punch a line. Keep it if it is there; do not add it.

**The ".." pause.** He uses two dots mid-sentence as a breath, in drafts and in chat. Convert to "..." for published prose, but keep the pause - do not replace it with a comma or a period, because the hesitation is doing rhythmic work.

## Structure for anything longer than a paragraph

These are his most consistently applied rules and they were missing from the register table. They apply to Notion docs, strategy writeups, retros, postmortems, long Slack posts, and any written answer he has to read on a phone.

**Lead with a TL;DR.** A snappy opening paragraph he can read on a phone in 30 seconds, then three to five bullets. Full detail below that. Not an executive summary that restates the doc - the actual answer, up front.

**One strong recommendation, not a menu.** He does not want three options with trade-offs listed neutrally. Pick one, say why, and name the specific benchmark or condition that would change it. Surfacing a hard trade-off is welcome; hiding behind a comparison table is not.

**Insight-led, not announcement-led.** Open with the thing that is true and non-obvious, not with the fact that something happened. "We hired someone" is an announcement. "Sprint data says XL items almost never close, so this is a decomposition problem, not a capacity problem" is an insight. The second shape is the one he reaches for.

**Name what is out of scope.** Explicit "not doing" lists are part of how he communicates in strategy docs, not an afterthought.

**Build around his anchors, do not replace them.** When he supplies a hook, an opening line, a hashtag, or a phrase he clearly likes, that is the fixed point. Edit around it. Swapping his hook for a better one is the fastest way to make the output feel not-his, even when the replacement is objectively sharper.

## What to cut, always

Cut on sight, whether it came from him or from you:

- Corporate cushioning: "I genuinely appreciate you taking the time to", "I wanted to reach out", "as you may know"
- Recruiter and LinkedIn boilerplate: "Should your circumstances change down the road", "excited to share", "humbled and honored", "thrilled to announce"
- Vague promises: "your feedback will shape how we do this going forward" - either say what changes or cut the line
- Triplet adjectives with no facts behind them: "fast, reliable, and scalable"
- Setup sentences that only announce what the next sentence says
- Anything hedged into meaninglessness: "it could be argued that", "somewhat", "arguably"
- Em dashes. Spaced hyphens instead, per house style.

Rough target: a draft handed to you should come back 20-30% shorter. If it came back longer, you added padding.

## Editing his drafts

This is the most common use of this skill, and the one where judgment matters. Split what you see into three buckets.

**Fix silently - real errors:**
- British spellings: realised, organise, recognise, whilst
- Missing or wrong articles: "in era of AI" to "in the AI era", "limits of scaling" to "the limits of scaling"
- Tense slips: "I had yet again realised" to "I realized yet again"
- Preposition collocations: "architecture in Databricks" to "architecture on Databricks"
- Slash-heavy lists: "data science / ML teams" to "data science and ML teams"
- Czech word order that reads stiff in English

**Keep - this is voice, not error:**
- The ".." pause
- Fragments and one-line paragraphs
- Starting a sentence with And, But, or So
- Direct address to the reader
- Caps for emphasis
- Rhetorical questions
- Slight over-enthusiasm when he is crediting other people

**Flag, don't silently change:**
- Anything that alters a claim, a number, or who gets credit
- Cutting a named person
- A structural rewrite that changes the argument

Then say what you changed and why, in a couple of lines. He wants to see the diff logic, not just the output. Don't narrate every comma.

## Examples

**LinkedIn, before and after**

Before (his draft):
> Six mentoring sessions usually take me longer.. last week, it all happened in two hours. "What? 20 minutes each?!" you might ask. From both sides, it is challenging whether you are a mentee or a mentor in my case. I had yet again realised how broad the area of DATA can be: from managing data science / ML teams, through building data products in era of AI, all the way to limits of scaling data architecture in Databricks.

After:
> Six mentoring sessions usually take me longer... last week, it all happened in two hours. "What? 20 minutes each?!" you might ask. And yes - it's challenging on both sides, whether you're the mentee or, in my case, the mentor. I realized yet again how broad the data field can be: from managing data science and ML teams, through building data products in the AI era, all the way to the limits of scaling data architecture on Databricks.

What moved: British spelling, missing articles, tense, the slash, the Databricks preposition. What stayed: the pause, the shouted quote, the "from X, through Y, all the way to Z" ladder, the whole rhythm.

**Email, before and after**

Before:
> Should your circumstances or interests change down the road, don't hesitate to reach out. I'd be happy to reconnect.

After:
> If something changes on your end, ping me. I'd happily pick this up again.

**Feedback, before and after**

Before:
> I think there might be room to be a bit more proactive in how we approach stakeholder requests, if that makes sense?

After:
> We're reacting instead of driving. I want us picking the top three things each sprint and saying no to the rest.

**Slack to the team (Czech, no diacritics)**

> Ahoj tyme, :wave: dekuji vsem, kdo vyplnili feedback na nas offsite. Tady je rychly souhrn.
>
> *Cisla*
> • Celkove hodnoceni: *6.5 / 7*
> • Efektivita workshopu: *4.7 / 5*
>
> *Co vylepsit priste* :memo:
> • :arrows_counterclockwise: *Opakovat kvartalne* - nejcastejsi prani
> • :dart: Odchazet s *jasnejsimi dalsimi kroky*
>
> Dekuji vsem za super den! :slightly_smiling_face:

Pattern: greeting plus wave, thanks up front, bold section labels, one emoji per bullet at most, warm close. No diacritics anywhere.

## Before you hand it over

- Does the first line make someone want the second one?
- Is there a number, name, or specific in the first two lines?
- Shorter than what he gave you?
- Zero em dashes, US English, sentence case, Oxford comma?
- Would he actually say this out loud, or does it read like it was approved rather than written?
- If Czech: diacritics stripped?

More detailed raw samples are in `references/samples.md` - read it when you need to calibrate a register you have not written in before, or when a draft feels close but not quite right.
