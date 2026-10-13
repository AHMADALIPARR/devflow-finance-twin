# Preservation report

Baseline source revision: `289e05876f15965a95f990ed178961aee0ebcb73`.

All 717 baseline paths were checked against their recorded checkout SHA-256 values after validation and documentation generation: **717 matched; zero missing or changed**. Git blob IDs and sizes are retained in [source inventory](SOURCE_INVENTORY.json), allowing platform-neutral comparison separately from CRLF-adjusted checkout bytes.

Permitted additions: `REPOSITORY_GUIDE.md` and files under `docs/repository-governance/`. No existing file, directory, license, media asset or implementation was modified, deleted, renamed or repaired. Temporary benchmark drivers, fixture ledgers and compiler output were stored outside this checkout. Existing Git history and publication documents remain untouched.

Before committing, validate that every staged change has status `A` and belongs to the permitted addition paths. Recheck the baseline SHA-256 values and the baseline Git-tree object IDs; inspect every new local Markdown link. Branch/commit metadata necessarily changes during publication and is outside the source-byte preservation claim.

This documentation introduces no effective relicensing, runtime enforcement, Hub publication, training artifact, financial data or secret-bearing execution trace.
