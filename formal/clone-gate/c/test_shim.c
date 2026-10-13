/* SPDX-License-Identifier: LicenseRef-Sovereign-Leviathan-SL-AGPL3-001 */
#include "clonegate.h"
#include <stdio.h>
static int fixture(const char *path, int length, int byte) {
    FILE *file = fopen(path, "wb"); if (!file) return 0;
    for (int i = 0; i < length; ++i) if (fputc(byte, file) == EOF) { fclose(file); return 0; }
    return fclose(file) == 0;
}
int main(void) {
    const char *fp = "0e0e0e0e0e0e0e0e0e0e0e0e0e0e0e0e";
    if (!fixture("challenge.bin",16,0) || !fixture("key.bin",32,0) || !fixture("changed.bin",16,1) || !fixture("short.bin",15,0)) return 10;
    if (clone_gate_init() != 0) return 11;
    if (clone_gate_entry("challenge.bin","key.bin",fp) != 0) return 12;
    if (clone_gate_entry("changed.bin","key.bin",fp) != 1) return 13;
    if (clone_gate_entry("short.bin","key.bin",fp) != 2) return 14;
    if (clone_gate_entry("challenge.bin","key.bin","00000000000000000000000000000000") != 3) return 15;
    if (clone_gate_entry(NULL,"key.bin",fp) != 3) return 16;
    clone_gate_shutdown();
    puts("C ABI: checks passed"); return 0;
}
