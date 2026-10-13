# License-ID: SL-AGPL3-001 | Covenant-Version: 1.0 | Project policy reference
# SPDX-License-Identifier: LicenseRef-Sovereign-Leviathan-SL-AGPL3-001
# Main project policy: LICENSES/LicenseRef-Sovereign-Leviathan-SL-AGPL3-001.txt.
# Existing file, component and third-party notices and grants are preserved.

CC = gcc
CFLAGS = -std=c11 -Wall -Wextra -O2 -Iinclude
SRCS = src/lexer.c src/parser.c src/ir.c src/codegen.c src/symtab.c src/regalloc.c src/main.c
OBJS = $(SRCS:.c=.o)
TARGET = klc

all: $(TARGET)

$(TARGET): $(OBJS)
	$(CC) $(CFLAGS) -o $@ $^

src/%.o: src/%.c
	$(CC) $(CFLAGS) -c -o $@ $<

clean:
	rm -f $(OBJS) $(TARGET)

test: $(TARGET)
	./$(TARGET) examples/word_arith.kl -emit-ir
	./$(TARGET) examples/bit_ops.kl -emit-ir
	./$(TARGET) examples/parallel_add.kl -emit-ir

test-regalloc: $(TARGET)
	./$(TARGET) examples/word_arith.kl -emit-ir -regalloc
	./$(TARGET) examples/parallel_add.kl -emit-ir -regalloc

test-ast: $(TARGET)
	./$(TARGET) examples/word_arith.kl -dump-ast

.PHONY: all clean test test-regalloc test-ast
