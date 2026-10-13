// SPDX-License-Identifier: LicenseRef-Sovereign-Leviathan-SL-AGPL3-001
// Licensing: see LICENSES/LicenseRef-Sovereign-Leviathan-SL-AGPL3-001.txt; preserve existing contributor notices.

#ifndef KERNEL_PARSER_H
#define KERNEL_PARSER_H

#include "lexer.h"
#include "ast.h"

typedef struct {
    Lexer *lex;
    Token current;
    Token previous;
    int had_error;
    int panic;
} Parser;

void parser_init(Parser *P, Lexer *L);
AstNode *parse_module(Parser *P);

#endif
