/* SPDX-License-Identifier: LicenseRef-Sovereign-Leviathan-SL-AGPL3-001 */
#ifndef CLONEGATE_H
#define CLONEGATE_H
#ifdef _WIN32
#define CLONE_API __declspec(dllexport)
#else
#define CLONE_API
#endif
#ifdef __cplusplus
extern "C" {
#endif
/* Stable C ABI to the checked subprocess, without assumed RefC runtime hooks. */
CLONE_API int clone_gate_entry(const char *, const char *, const char *);
CLONE_API int clone_gate_init(void);
CLONE_API void clone_gate_shutdown(void);
#ifdef __cplusplus
}
#endif
#endif
