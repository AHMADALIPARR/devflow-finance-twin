# SPDX-License-Identifier: LicenseRef-Sovereign-Leviathan-SL-AGPL3-001
IDRIS2 ?= idris2
CC ?= cc
BUILD := build
GATE := $(abspath $(BUILD)/exec/clone_gate)
.PHONY: all exe lib check
all: exe lib
exe:
	$(IDRIS2) --build clone-gate-exe.ipkg
lib: exe
	$(CC) -shared -fPIC -Wall -Wextra -Werror -DCLONE_GATE_EXECUTABLE='"$(GATE)"' c/clonegate_shim.c -o $(BUILD)/libclonegate.so
check: lib
	$(CC) -Wall -Wextra -Werror c/test_shim.c -L$(BUILD) -lclonegate -Wl,-rpath,'$(abspath $(BUILD))' -o $(BUILD)/test-shim
	mkdir -p $(BUILD)/fixtures
	cd $(BUILD)/fixtures && ../test-shim
