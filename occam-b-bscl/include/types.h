// SPDX-License-Identifier: LicenseRef-Sovereign-Leviathan-SL-AGPL3-001
// Licensing: see LICENSES/LicenseRef-Sovereign-Leviathan-SL-AGPL3-001.txt; preserve existing contributor notices.

/* in include/types.h, replace:
   struct Node;
   struct DiagList;
   ... typecheck_program(struct Node *prog, FuncTab *ft, struct DiagList *dg, ...)
   with: */
#include "diagnostics.h"
struct Node;
bool typecheck_program(struct Node *prog, FuncTab *ft, DiagList *dg,
                       const char *file);
