# License-ID: SL-AGPL3-001 | Covenant-Version: 1.0 | Project policy reference
# SPDX-License-Identifier: LicenseRef-Sovereign-Leviathan-SL-AGPL3-001
# Main project policy: LICENSES/LicenseRef-Sovereign-Leviathan-SL-AGPL3-001.txt.
# Existing file, component and third-party notices and grants are preserved.

OCCAMC = occamc
OCCAMFLAGS = -v

SOURCES = \
  RetroGPUTypes.occ \
  Registers.occ \
  ALU.occ \
  Warp.occ \
  SharedMemory.occ \
  GlobalMemory.occ \
  Synchronization.occ \
  Tensor.occ \
  RetroGPUCompiler.occ

EXAMPLES = \
  examples/GemmKernel.occ

TESTS = \
  tests/CompilerTests.occ

.PHONY: all clean test build

all: build

build:
	$(OCCAMC) $(OCCAMFLAGS) -o retro-gpu $(SOURCES) RetroGPUCompiler.occ

test: build
	$(OCCAMC) $(OCCAMFLAGS) -o test-retro-gpu $(SOURCES) $(TESTS)
	./test-retro-gpu

clean:
	rm -f retro-gpu test-retro-gpu *.o *.tce

.PHONY: all clean test build
