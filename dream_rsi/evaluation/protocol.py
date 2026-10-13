# SPDX-License-Identifier: LicenseRef-Sovereign-Leviathan-SL-AGPL3-001
# Licensing: see LICENSES/LicenseRef-Sovereign-Leviathan-SL-AGPL3-001.txt; preserve existing contributor notices.

"""Evaluator protocol used by domain adapters and replay."""
from dataclasses import dataclass
from typing import Any, Dict, Protocol


@dataclass(frozen=True)
class Evaluation:
    score: float
    valid: bool
    details: Dict[str, Any]


class Evaluator(Protocol):
    name: str
    def evaluate(self, execution: Any, task: str) -> Dict[str, Any]: ...


def validate_score(value: Any) -> float:
    score = float(value)
    if score != score or score in (float("inf"), float("-inf")):
        raise ValueError("score must be finite")
    return max(0.0, min(1.0, score))
