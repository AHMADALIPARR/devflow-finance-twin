/* SPDX-License-Identifier: LicenseRef-Sovereign-Leviathan-SL-AGPL3-001 */

/* examples/channel.b */
main() {
    c = chan();
    send(c, 123);
    out(recv(c)); /* 123 */
}
