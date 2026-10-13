# SPDX-License-Identifier: LicenseRef-Sovereign-Leviathan-SL-AGPL3-001
# Licensing: see LICENSES/LicenseRef-Sovereign-Leviathan-SL-AGPL3-001.txt; preserve existing contributor notices.

"""Evaluation contracts and deterministic score validation."""
from .protocol import Evaluation, Evaluator, validate_score

__all__ = ["Evaluation", "Evaluator", "validate_score"]
