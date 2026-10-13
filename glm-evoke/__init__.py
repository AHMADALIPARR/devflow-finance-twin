# License-ID: SL-AGPL3-001 | Covenant-Version: 1.0 | Project policy reference
# Main project policy: LICENSES/LicenseRef-Sovereign-Leviathan-SL-AGPL3-001.txt.
# Existing file, component and third-party notices and grants are preserved.

# ============================================================================
# glm-evoke/__init__.py
# GLM Evoke Engine — Dual-regime transformer with sealed execution
# License: GPL 2.0
# ============================================================================

__version__ = "0.1.0"
__author__ = "Ahmad"

from harness import GLMEvokeEngine, ExecutionSeal, ExecLog
from attest import AttestationLog
from core.loader import CheckpointLoader, GateError
from core.kv_cache import PagedKVCache
from core.blocks import build_mask, schema_for

__all__ = [
    "GLMEvokeEngine",
    "ExecutionSeal",
    "ExecLog",
    "AttestationLog",
    "CheckpointLoader",
    "GateError",
    "PagedKVCache",
    "build_mask",
    "schema_for",
]
