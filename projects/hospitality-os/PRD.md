# PRD - Hospitality operating system (matching the Mews offering)

Status: draft v1
Owner: Vojta Kopal
Last updated: 2026-07-01
Related: `goals.yaml` side_projects (recommendation_system_or_upsell_engine, hospitality_analytics_product)

## TL;DR

This PRD specifies a product that matches what Mews sells today: an AI-native operating
system for hospitality spanning PMS, payments, POS, revenue management, distribution, guest
messaging, automations and a marketplace, all on one data model. It then states plainly that
cloning that surface head-on is the wrong bet for a small team, and recommends building one
wedge first - an AI-native revenue and upsell layer that rides Mews' own marketplace - then
expanding toward the fuller platform only if the wedge earns the right.

- Mews is not a PMS. It is a payments-monetised platform with ~15,000 customers in 85
  countries and 1,000+ marketplace integrations. The core is a moat of integrations,
  compliance and installed base, not code.
- Replicating the full surface is a 100+ engineer, multi-year, heavily regulated effort
  (card payments, PSD2/SCA, PCI-DSS, tax/fiscalisation per country). That is a funding and
  org-scale problem, not a technical one.
- The defensible wedge is the layer Mews and every incumbent still treats as a bolt-on:
  AI-driven revenue optimisation and upsell, sitting on top of existing PMSs via open APIs.
- Recommendation: build the wedge, distribute through the Mews Marketplace and Apaleo/Cloudbeds
  APIs, prove revenue-per-available-room lift, and only then decide whether to move down the
  stack toward a full PMS.
- This document specifies both: the full target (so "all of Mews" is concrete) and the
  wedge we actually build first.

---

## 1. Background and problem

Mews positions itself as "the operating system for hospitality". As of Unfold 2026 it unifies
PMS, RMS, guest messaging, automations and accounts receivable on a single data model, and
markets a 476% three-year ROI (IDC), 150 million pricing calculations per day, 15,000 customers
across 85 countries, and 1,000+ marketplace integrations.

The industry problem Mews solves: hotel tech is a fragmented stack of aging on-premise systems
(Opera, Protel) glued together with brittle integrations. Independents and small groups run
5-10 disconnected tools. Mews collapsed that into one cloud platform monetised primarily through
embedded payments, not licence fees.

The problem for us: the market is real and large, but the incumbent moat is distribution,
payments economics and compliance, not features. Any build plan that ignores that loses.

## 2. The target - what Mews offers today

Full current surface, grouped. This is the definition of "everything Mews offers" so scope
decisions are explicit.

### 2.1 Core platform
- **PMS (Commander/Operations):** reservations, front desk, check-in/out, housekeeping,
  rate and availability management, guest profiles, billing, multi-property.
- **Single data model:** every module reads and writes one guest/reservation/room graph.
  This is the real product - it is what makes the AI layer possible.
- **Open API and Marketplace:** 1,000+ integrations, developer platform, connector ecosystem.
  Third parties extend Mews rather than compete with it.

### 2.2 Monetisation engine
- **Payments:** embedded card processing (Adyen/Stripe rails), tokenised guest cards,
  automated pre-auth, capture, refunds. This is the primary revenue line.
- **Accounts Receivable (2026):** B2B invoice-to-cash inside the platform, automatic issuance
  at billing closure, ~100% automated reconciliation.
- **POS (2026 Best POS):** food, beverage and retail point of sale on the same profile/folio.

### 2.3 Revenue and distribution
- **RMS (2026):** embedded dynamic pricing, 150M calculations/day, automated rate changes
  against live demand.
- **Booking Engine:** conversion-optimised direct booking, upsells, currency conversion,
  real-time availability.
- **Channel Management (2026):** native SiteMinder distribution to OTAs and channels.

### 2.4 Guest experience and operations
- **Guest Messaging (2026):** unified inbox across WhatsApp, SMS, OTA messages, email, with
  full reservation/guest/room context; can autonomously action tasks via **Mews Agent**.
- **Automations (2026):** natural-language and template workflows - upgrades, amenities,
  task routing.
- **Kiosk / online check-in / self-service.**
- **Reporting and analytics.**

### 2.5 Cross-cutting
- **AI-native (Mews Agent):** an agent layer over the single data model that reads context and
  takes action across messaging, operations and automations.
- **Compliance:** PCI-DSS, PSD2/SCA, per-country tax and fiscalisation, GDPR.

## 3. Strategic assessment - why not clone all of it

Per the operating principle that organisational feasibility, not technical capability, is the
binding constraint:

1. **The moat is not features.** It is the installed base, the 1,000+ integration marketplace,
   payments economics at scale, and country-by-country compliance. Feature parity buys nothing
   against that.
2. **Payments is the business model and the hardest part.** Replicating embedded payments means
   PCI-DSS scope, PSD2/SCA, KYC, chargeback handling, and processor economics that only work at
   volume. This alone is a regulated fintech company.
3. **Fiscalisation is a per-country tax.** Every market (Germany KassenSichV, France, Italy,
   Portugal, Austria) has distinct fiscal receipt law. Mews' 85-country footprint is years of
   compliance work, not code.
4. **Throughput reality.** Grounding ambition in observed throughput (a core operating rule):
   a small team ships in the tens of points per sprint. Mews is hundreds of engineers over a
   decade. A 1:1 clone is not on any realistic roadmap.

Conclusion: build head-to-head and you compete on the incumbent's terms and lose. The move is
to attack the layer where the incumbent is weakest and where AI changes the economics.

## 4. Recommendation - the wedge

**Build an AI-native revenue and upsell layer that sits on top of existing PMSs, distributed
through their marketplaces (starting with Mews).**

Why this wedge, one strong recommendation:
- It is the most concrete of the stated side-project ideas (upsell engine) fused with the
  hospitality-analytics idea, and it is buildable by a small team.
- It rides the incumbent's distribution instead of fighting it: ship as a Mews Marketplace app,
  then Apaleo and Cloudbeds. Their open APIs are the on-ramp.
- It attacks margin expansion (RevPAR/upsell), which hotels pay for directly and measurably,
  rather than replacing systems of record (high switching cost, low willingness to churn).
- AI genuinely changes the unit economics here: per-guest, per-stay pricing and offer
  personalisation that legacy RMS rules engines cannot match.
- It generates exactly the operational content and positioning value referenced in the
  external-presence goals.

### 4.1 Target users
- Primary: independent hotels and small groups (5-50 properties) already on a cloud PMS.
- Buyer: revenue manager / GM / owner-operator.
- Secondary later: management companies wanting a portfolio revenue view.

### 4.2 Jobs to be done
1. "Price my rooms correctly every day without a full-time revenue manager."
2. "Sell more to guests I already have - upgrades, late checkout, F&B, experiences."
3. "Tell me in plain language why revenue moved and what to do about it."

### 4.3 Product pillars (the wedge)
- **P1 Revenue intelligence:** ingest reservations, rates, pace and market signals via PMS API;
  produce a daily recommended-rate and pickup narrative.
- **P2 Upsell engine:** per-guest offer selection (upgrade, early check-in, late checkout,
  amenities, F&B) triggered pre-arrival and in-stay, written back to the PMS folio.
- **P3 Conversational analytics:** natural-language questions over the property's own data
  ("why did last weekend underperform?"), grounded in a semantic layer.
- **P4 Agentic actions (later):** move from recommend to auto-execute rate and offer changes
  with guardrails, the same recommend-then-act arc Mews Agent follows.

## 5. Scope

### 5.1 In scope (v1, the wedge)
- Read/write integration with Mews Open API (reservations, rates, availability, profiles, folio).
- Revenue recommendations (rate + pickup narrative), upsell offer selection and write-back.
- A semantic layer over the property data model and a conversational interface on top.
- Marketplace-app packaging, onboarding, per-property billing.

### 5.2 Out of scope (v1)
- Owning payments, card processing, PCI scope. Use the PMS's existing payment rails.
- PMS system-of-record functions (front desk, housekeeping, folio ownership).
- POS, channel management, accounts receivable, fiscalisation.
- Multi-country tax/compliance beyond GDPR data handling.

### 5.3 Explicitly deferred (the "become Mews" path)
Only if the wedge proves RevPAR lift and reaches meaningful ARR: evaluate moving down the stack
toward a lightweight AI-native PMS for independents. Treated as a separate future PRD, gated on
evidence, not assumed.

## 6. Requirements

### 6.1 Functional (v1)
- FR1: OAuth connect to a Mews property; sync reservations, rates, availability, guest profiles,
  folio on a scheduled + webhook basis.
- FR2: Daily rate recommendation per room type with confidence and rationale.
- FR3: Pace/pickup narrative in plain language, refreshed daily.
- FR4: Upsell offer catalogue per property; per-reservation offer ranking; delivery trigger
  (pre-arrival messaging or PMS-native) and folio write-back on acceptance.
- FR5: Conversational analytics endpoint answering NL questions over the property's data with
  cited figures.
- FR6: Per-property onboarding, role-based access, audit log of any write-back action.
- FR7: Billing - per-property subscription and/or performance fee on incremental upsell revenue.

### 6.2 Non-functional
- Data model: one normalised guest/reservation/room/folio graph per property (mirror the single
  data model that makes Mews' AI work); a dbt-style semantic layer on top, contract-tested.
- AI: recommend-then-act. Every autonomous action gated behind explicit guardrails and reversible.
- Security/privacy: GDPR, data-residency options (EU-first), PII minimisation, no card data in
  scope. SOC 2 on the roadmap before enterprise.
- Reliability: write-backs idempotent; never corrupt the PMS system of record.
- Latency: recommendations batch-daily; conversational queries interactive (<5s p95).

## 7. Success metrics
- North star: incremental RevPAR / revenue-per-guest lift attributable to the product
  (measured against a holdout).
- Activation: property connected and receiving daily recommendations within 24h of signup.
- Upsell: attach rate and incremental upsell revenue per occupied room.
- Retention: net revenue retention > 110% by month 12.
- Trust: share of recommendations accepted; ratio of auto-executed actions reverted (< 2%).

## 8. Risks
- **Platform dependency:** we live on the PMS's API and marketplace terms; they can change or
  build the feature themselves (Mews RMS already exists). Mitigate by being multi-PMS early and
  better at AI personalisation than an embedded rules engine.
- **Attribution:** proving lift is hard; without a credible holdout the value story collapses.
  Mitigate with built-in experimentation from day one.
- **Cold start:** thin data on new/independent properties. Mitigate with market signals and
  cross-property priors.
- **Focus risk (personal):** this is a 15%-weight side project. It must not draw from the
  50%-weight Apify data-org work. Guardrail in the build plan.

## 9. Open questions
- Which PMS first - Mews only, or Mews + Apaleo (cleanest API) together?
- Pricing model: flat SaaS, performance fee, or hybrid? Performance fee aligns incentives but
  slows deals.
- Solo/nights-and-weekends build vs. co-founder + small team - this decides the timeline in the
  build plan more than anything technical.

See `BUILD-PLAN.md` for the phased plan, architecture, cost and decision gates.
