/* SPDX-License-Identifier: LicenseRef-Sovereign-Leviathan-SL-AGPL3-001 */
#define _POSIX_C_SOURCE 200809L
#include "clonegate.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <ctype.h>
#ifndef CLONE_GATE_EXECUTABLE
#error Define CLONE_GATE_EXECUTABLE as the absolute path of the checked Idris CLI
#endif
#ifdef _WIN32
#include <windows.h>
#else
#include <spawn.h>
#include <sys/wait.h>
#include <errno.h>
#include <unistd.h>
extern char **environ;
#endif
int clone_gate_init(void) { return 0; }
void clone_gate_shutdown(void) { }
int clone_gate_entry(const char *challenge, const char *key, const char *expected) {
    if (!challenge || !key || !expected || !*challenge || !*key || strlen(expected) != 32) return 3;
    for (size_t i = 0; i < 32; ++i) if (!isxdigit((unsigned char)expected[i])) return 3;
#ifdef _WIN32
    if (strpbrk(challenge, "\"\r\n") || strpbrk(key, "\"\r\n")) return 3;
    size_t size = strlen(CLONE_GATE_EXECUTABLE) + strlen(challenge) + strlen(key) + 128;
    if (size > 32767) return 3;
    char *command = malloc(size);
    if (!command) return 2;
    snprintf(command, size, "\"%s\" --challenge \"%s\" --key \"%s\" --expected %s", CLONE_GATE_EXECUTABLE, challenge, key, expected);
    int count = MultiByteToWideChar(CP_UTF8, MB_ERR_INVALID_CHARS, command, -1, NULL, 0);
    wchar_t *wide = count ? malloc((size_t)count * sizeof(wchar_t)) : NULL;
    if (!wide) { free(command); return 2; }
    MultiByteToWideChar(CP_UTF8, MB_ERR_INVALID_CHARS, command, -1, wide, count);
    free(command);
    STARTUPINFOW startup = {0}; startup.cb = sizeof(startup);
    PROCESS_INFORMATION process = {0};
    BOOL launched = CreateProcessW(NULL, wide, NULL, NULL, FALSE, CREATE_NO_WINDOW, NULL, NULL, &startup, &process);
    free(wide);
    if (!launched) return 2;
    DWORD result = 2;
    if (WaitForSingleObject(process.hProcess, INFINITE) == WAIT_OBJECT_0) GetExitCodeProcess(process.hProcess, &result);
    CloseHandle(process.hThread); CloseHandle(process.hProcess);
    return result <= 3 ? (int)result : 2;
#else
    pid_t child;
    char *argv[] = {CLONE_GATE_EXECUTABLE, "--challenge", (char *)challenge, "--key", (char *)key, "--expected", (char *)expected, NULL};
    if (posix_spawn(&child, CLONE_GATE_EXECUTABLE, NULL, NULL, argv, environ)) return 2;
    int status;
    while (waitpid(child, &status, 0) < 0) if (errno != EINTR) return 2;
    if (!WIFEXITED(status)) return 2;
    int result = WEXITSTATUS(status);
    return result <= 3 ? result : 2;
#endif
}
