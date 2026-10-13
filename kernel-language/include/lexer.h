// SPDX-License-Identifier: LicenseRef-Sovereign-Leviathan-SL-AGPL3-001
// Licensing: see LICENSES/LicenseRef-Sovereign-Leviathan-SL-AGPL3-001.txt; preserve existing contributor notices.

#ifndef KERNEL_LEXER_H
#define KERNEL_LEXER_H

#include "token.h"

typedef struct {
    const char *src;
    const char *cur;
    const char *start;
    int line;
    int col;
    Token current;
    Token lookahead;
    int has_lookahead;
} Lexer;

void lexer_init(Lexer *L, const char *source);
Token lexer_next(Lexer *L);
Token lexer_peek(Lexer *L);
void lexer_error(Lexer *L, const char *msg);

#endif
