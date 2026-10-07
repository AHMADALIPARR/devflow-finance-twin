# Copyleft and commercial governance review

Status: **unresolved effective scope; proposed owner release hold**. This document records evidence and release controls. It grants no new rights, changes no existing license and supplies no enforceability opinion.

## Existing texts and conflicts

| Evidence | Observed terms/scope | Required resolution |
|---|---|---|
| [Root AGPL notice](../../LICENSE-AGPL-3.0) | Explicitly lists ten WASM/WAT artifacts; assigns all other files to FSL. It is a short notice, not the complete standard license text. | Reconcile with node headers and root claims; supply full operative text in a future authorized release |
| [Root FSL-named text](../../LICENSE-FSL-1.1) | Royalty-free grant; section 2 perpetual/no-charge/irrevocable copyright permissions; section 3 conversion to Apache 2.0 two years after initial distribution; Wyoming law | Do not infer a restrictive commercial license from its filename. Identify initial distribution dates and actual covered artifacts; verify standard-license equivalence before using a standard identifier |
| [Opaque source license](../../SNAPKITTY%20OPAQUE%20SOURCE%20LICENSE%20v1.0) | Separate written permission for commercial exploitation; preserves attribution/provenance; no patent grant; English controls | Identify specifically covered works and rights holder; reconcile with prior grants |
| [Covenant](../../SOVEREIGN_LEVIATHAN_COVENANT.md), [src license](../../src/LICENSE) | Claims AGPL foundation plus commercial/governance conditions, England and Wales jurisdiction and broad wrapper forfeiture language | Resolve incompatibilities; do not treat forfeiture or automatic ownership transfer assertions as established legal effects |
| [Recursive license](../../src/LICENSE-RECURSIVE-INFECTION) | Distinguishes covered works, combined works and independent interfaces; preserves AGPL operative terms | Reconcile contrary automatic scope assertions elsewhere |
| [README](../../README.md) and observed node headers | Broad AGPL/custom covenant claims; 351 observed header markers | Owner-approved path-level determination needed; marker presence does not establish ownership or resolve conflicting grants |

## Preserve copyleft without misrepresenting restrictions

AGPL permits charging for copies. Its network-source obligation is scoped to its terms, particularly modified covered software under section 13. Sections 7 and 10 constrain additional restrictions; a mandatory commercial fee cannot simply be represented as ordinary AGPL. Independent aggregation is addressed separately by section 5. These points follow the [standard AGPL text](https://opensource.org/license/agpl-3-0); applicability to this collection requires scope and rights review.

Strict owner governance should preserve applicable source availability, copyright notices, provenance and license obligations. Commercial contracts for owner-controlled custom-licensed artifacts must name the works, revision, rights, consideration, duration and authorized signatory. Alternative licenses require sufficient rights from all contributors. New documentation or a clone gate cannot revoke already granted permissions or make unrelated works automatically owned by the project.

## Proposed release control record

For each artifact record: path and checksum; preferred source; creator/contributor evidence; third-party origin and notices; operative license text and scope basis; prior grants; initial publication date; corresponding-source obligations; commercial authorization where legally applicable; reviewer and owner disposition. Use **unresolved** when evidence conflicts. The current inventory supplies paths and hashes, not completed rights determinations.

Keep existing notices intact. Escalate conflicting scope instead of silently substituting a license. Publish an owner-approved scope statement only after rights review and separate authorization to amend existing materials. Stop new owner-branded releases with unresolved permissions, missing correspondence or unsupported proprietary-rights claims. This proposed process does not prohibit recipients from exercising valid existing grants.

Access control is operational: private storage and Hub manual gating can limit future distribution when authorized. Public copies already obtained cannot be made inaccessible through documentation. No private setting, technical gate, payment enforcement or blanket commercial protection was implemented in this increment.
