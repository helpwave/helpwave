# helpwave products

Source of truth for public positioning: [helpwave.de/products](https://helpwave.de/products).

helpwave products work independently or as a connected suite. Each one is modular, open, and built for healthcare operations in Europe.

## Foundation

### helpwave intelligence

The layer that ties the stack together. It connects products and data sources, maps real workflows (not only the SOP on paper), flags bottlenecks, and exposes insights through open APIs.

- Workflow mapping from clinical events
- Inefficiency and deviation detection
- Cross-product AI assistance surface
- Non-disruptive integration with existing infrastructure

[helpwave.de](https://helpwave.de) · Trust & hosting: [legal overview](https://helpwave.de/legal)

## Clinical operations

### helpwave tasks

The app clinical teams open at the bedside — not a billing front-end. Tick a task; a signed, timestamped event lands in the process model that feeds helpwave intelligence.

- SOP-aligned task management for wards and teams
- Real-time collaboration across roles
- Ward views and patient task lists (structure from scaffold)
- Open source: [github.com/helpwave/tasks](https://github.com/helpwave/tasks)

[Product page](https://helpwave.de/products/tasks)

### helpwave scaffold

Visual editor for the organization once: networks, hospitals, practices, clinics, wards, rooms, beds, teams, users, competencies and roles. helpwave id, helpwave tasks and connected apps inherit the same model.

- Drag-and-drop healthcare node types
- Import / export as JSON
- Open source: [github.com/helpwave/scaffold](https://github.com/helpwave/scaffold)

[Product page](https://helpwave.de/products/scaffold)

### helpwave id

Identity under every helpwave product — and third-party systems you plug in.

- SSO · OAuth 2.1 / OIDC · MFA (TOTP, WebAuthn, eHBA / smartcard)
- Role- and ward-aware access scoped to scaffold
- Audit trails for authentication and authorization
- On-premise or hosted in Germany

[Product page](https://helpwave.de/products/id)

## Insights & assistance

### helpwave analytics

Operational intelligence from clinical events — bottlenecks, throughput, utilization, SOP vs. reality — drillable down to the cases that matter.

[Product page](https://helpwave.de/products/analytics)

### helpwave assistant

**Closed trial — not generally available.** Planned AI co-pilot grounded in the hospital’s own event stream (drafts, SOP surfacing, traceable answers). People sign off; the AI does not.

[Product page](https://helpwave.de/products/assistant)

## Networks & ambulatory

### helpwave netmanager

For MVZ managers and boards of KBV-certified Praxisnetze: member management, multi-channel messaging, own storage and domain, surveys, events, member app.

[Product page](https://helpwave.de/products/netmanager)

### App zum Doc

Patient-facing, end-to-end encrypted channel between practices and patients — appointments, prescriptions, referrals, image findings, and more. iOS, Android, and modern browsers. Powered by helpwave.

- Practices own the practice key pair and dashboard
- Patients pair via QR; no mixed accounts
- Unified practice dashboard for telephony / mail / walk-ins: **in development** (App zum Doc channel itself is live)
- Dedicated site: [app-zum-doc.de](https://app-zum-doc.de)

[Product page](https://helpwave.de/products/app-zum-doc) · Brand kit: [`../brand/app-zum-doc/`](../brand/app-zum-doc/)

## Interoperability

### helpwave lab

Not a product to buy — a sandbox. Vendors plug software in; clinics test a coordinated stack before they buy. Built on shared building blocks (hightide, scaffold, id).

[helpwave.de/lab](https://helpwave.de/lab)

## Trust

Patient data stays in Germany — one isolated instance per customer. Hosted on a BSI C5-certified German cloud provider (not a hyperscaler). Own ISO 27001 and helpwave-scoped C5 certifications are in progress.

Details: [helpwave.de/legal](https://helpwave.de/legal)
