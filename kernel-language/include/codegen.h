// SPDX-License-Identifier: LicenseRef-Sovereign-Leviathan-SL-AGPL3-001
// Licensing: see LICENSES/LicenseRef-Sovereign-Leviathan-SL-AGPL3-001.txt; preserve existing contributor notices.

#ifndef KERNEL_CODEGEN_H
#define KERNEL_CODEGEN_H

#include "ast.h"
#include "ir.h"

IrModule *codegen(AstNode *module);

#endif
