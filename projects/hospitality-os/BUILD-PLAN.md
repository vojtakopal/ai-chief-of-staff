# Build plan - Hospitality operating system

Status: draft v1
Owner: Vojta Kopal
Last updated: 2026-07-01
Companion to: `PRD.md`

## TL;DR

The plan builds the wedge first (AI-native revenue and upsell layer on top of existing PMSs),
not the full Mews clone. It sequences four phases from a two-week integration spike to a
multi-PMS product, each gated by a hard go/kill decision. Timelines are given in two tracks -
solo nights-and-weekends and funded small team - because that choice, not the technology, sets
the pace. The full-Mews path is included only as a gated appendix, because attempting it now
would fail on funding and compliance, not code.

- Phase 0 (2-3 weeks): prove the Mews API can give and take the data we need. Kill early if not.
- Phase 1 (2-4 months): private beta with 3-5 friendly properties; recommend-only, prove lift.
- Phase 2 (4-8 months): Mews Marketplace launch, billing, second PMS (Apaleo).
- Phase 3 (8-18 months): agentic auto-execution with guardrails; portfolio view; scale.
- Full-platform path: a separate, evidence-gated decision - not part of this plan's commitment.

## Guiding constraints

1. **Grounded in throughput, not aspiration.** Every phase is scoped to what the actual team
   size can ship, not what would be nice.
2. **Feasibility is the binding constraint.** The gates below test market and organisational
   feasibility before technical scale-up, in that order.
3. **Protect the primary theme.** This is a 15%-weight side project (`goals.yaml`). If it starts
   pulling from the 50%-weight Apify data-org work or from protected family time, it pauses.
   That is a P1 flag, not a trade-off to make quietly.
4. **Ride distribution, do not rebuild it.** Every phase ships where hotels already are (PMS
   marketplaces), never as a standalone that needs its own demand generation.

## Team and pace - the decision that sets everything

| Track | Team | Realistic Phase 1 beta | Realistic Phase 2 launch |
|-------|------|------------------------|--------------------------|
| Solo, nights/weekends | 1 (Vojta) | ~4 months | ~10-12 months |
| Co-founder + 1 eng | 2-3 | ~2 months | ~6 months |
| Funded seed team | 4-6 | ~6 weeks | ~4 months |

Recommendation: do not start solo indefinitely. Run Phase 0 solo to de-risk, then decide on a
co-founder (ideally revenue-management domain, given your build is data/AI) before Phase 1. A
data/AI founder without a hospitality-commercial counterpart is the most common failure mode
here.

## Architecture

Deliberately boring and cheap to run at low volume; the AI is the only expensive part.

- **Ingestion:** Mews Open API (OAuth, webhooks + scheduled pulls) into a per-property store.
  Add Apaleo/Cloudbeds connectors behind one internal integration interface.
- **Data model:** one normalised guest/reservation/room/folio graph per property. A dbt-style
  semantic layer on top, contract-tested in CI - the same pattern as the Apify semantic-layer
  work, which makes this a genuine knowledge-transfer win, not a distraction.
- **Revenue engine:** pace/pickup features + a pricing model (start with a transparent
  statistical baseline, not a black box); market-signal enrichment.
- **Upsell engine:** per-reservation offer ranking; delivery via pre-arrival messaging or
  PMS-native; idempotent folio write-back with full audit log.
- **Conversational layer:** LLM over the semantic layer with tool-use for figures; answers cite
  numbers. Use the latest Claude models; recommend-then-act, never silent auto-write in v1.
- **Guardrails (Phase 3):** any autonomous rate/offer change bounded, reversible, logged, with
  per-property caps and a kill switch.

Stack keeps to what you already run well: Snowflake or Postgres + dbt, a light API service, a
thin operator UI. No premature platform building.

## Phases and gates

### Phase 0 - Integration spike (2-3 weeks, solo)
Goal: prove the Mews Open API returns reservations/rates/availability/profiles and accepts
folio write-backs in a sandbox.
Deliverables: working read sync for one test property; one successful write-back; a rough
data-model sketch.
**Gate G0 (go/kill):** if the API cannot deliver the data or write-backs reliably, the wedge as
specified does not work - stop and re-scope before investing further.

### Phase 1 - Private beta, recommend-only (2-4 months)
Goal: prove the product produces revenue lift a hotelier will pay for.
Scope: FR1-FR3, FR5, FR6 (recommendations, pace narrative, conversational analytics, audit).
No auto-execution. Upsell as recommendations a human actions.
Design partners: 3-5 friendly independent properties (warm network from Mews years).
Measurement: holdout or pre/post per property; qualitative "would you pay" interviews.
**Gate G1:** at least 3 partners show measurable lift and state willingness to pay. If not, the
value hypothesis is wrong - iterate or kill. Do not proceed to build billing/marketplace on
hope.

### Phase 2 - Marketplace launch and monetisation (4-8 months)
Goal: a sellable product with self-serve onboarding on one marketplace, then two PMSs.
Scope: add FR4 (upsell write-back), FR7 (billing), Mews Marketplace listing/certification,
Apaleo connector.
Milestones: Marketplace certification passed; first paying property; second PMS live; NRR
tracking in place.
**Gate G2:** paying-customer count and NRR trend justify continued investment vs. the
opportunity cost against primary goals. This is the "is this a business or a project" gate.

### Phase 3 - Agentic and scale (8-18 months)
Goal: move from recommend to act, and from single property to portfolio.
Scope: FR4 auto-execution with guardrails; management-company portfolio view; SOC 2; broaden
market signals.
**Gate G3:** unit economics (CAC vs. LTV, gross margin after AI cost) support scaling, and the
platform-dependency risk (Mews building this natively) is being outrun by AI-personalisation
quality.

## Go-to-market
- Distribution: PMS marketplaces (Mews first). No standalone demand-gen in early phases.
- Wedge message: "more revenue from the guests and rooms you already have," measured against a
  holdout - not "replace your PMS."
- Content flywheel: the operational work generates the exact writing/positioning the
  external-presence goals need. Build in public where it does not leak partner data.
- Pricing: start hybrid - modest SaaS floor + performance fee on incremental upsell revenue -
  to align incentives while keeping deals closeable. Revisit at G2.

## Cost and funding (order of magnitude)
- Phase 0-1: near-zero cash; time is the cost. Cloud + LLM spend in the low hundreds/month at
  beta scale.
- Phase 2: co-founder/first hire is the real cost; infra still modest. If funded, a small
  pre-seed (~$0.5-1.5M) buys the 4-6 person team and ~18 months of runway.
- The full-Mews path (appendix) is a different universe: tens of engineers, regulated payments
  and fiscalisation, and venture funding at Series A+ scale. Not fundable on a wedge's evidence,
  which is exactly why the wedge comes first.

## The full-platform path (gated appendix - not a current commitment)
Only relevant if the wedge reaches meaningful ARR and strategic pull toward system-of-record:
1. Lightweight AI-native PMS for independents (front desk, folio, housekeeping) on the existing
   data model.
2. Embedded payments via a BaaS/processor partner (do not build card processing) - accept the
   PCI/PSD2 scope only when volume justifies it.
3. Distribution and channel management via partnership (the SiteMinder model), not in-house.
4. Country-by-country fiscalisation, sequenced by market size.
Each step is its own PRD with its own funding and compliance gate. Sequencing this now would
violate the throughput and feasibility constraints above - hence deferred.

## Immediate next actions
1. Decide track (solo Phase 0 vs. recruit co-founder first). Recommended: solo Phase 0, then
   recruit.
2. Register for Mews Open API sandbox / developer access.
3. Line up 3-5 warm design-partner properties from the Mews-era network for Phase 1.
4. Timebox Phase 0 to three weekends; hold Gate G0 honestly before committing further.
5. Add a calendar guardrail so this never encroaches on the 50%-weight Apify work or family time.
