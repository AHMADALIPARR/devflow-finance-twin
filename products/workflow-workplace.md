<!--
License-ID: SL-AGPL3-001 | Covenant-Version: 1.0 | Project policy reference
Main project policy: LICENSES/LicenseRef-Sovereign-Leviathan-SL-AGPL3-001.txt.
Existing file, component and third-party notices and grants are preserved.
-->

# Workflow Workplace

Browser workplace, authentication helpers, coordinator and canvas templates.

Audience: Workflow application developers.

Source roots:

- `frontend`
- `backend`
- `canvas-templates`

Dependencies: None declared.

Package from the repository root:

```powershell
python scripts/product_suite.py bundle workflow-workplace
```

Release gates:

- Backend coordinator is an in-memory sketch; add persistence and session authorization
- Pin FastAPI/Pydantic dependencies and exercise the browser-to-backend flow
