<!-- SPDX-License-Identifier: LicenseRef-Sovereign-Leviathan-SL-AGPL3-001 -->
# Idris clone gate

`CloneGate.idr` implements the supplied attestation model: a 32-byte key, 14 toy rounds, a fixed expected state, a runtime decidable equality check, an indexed equality witness and an entry point calling the guarded payload. `Granted`, `Locked` and `Unlocked` are private constructors; callers obtain a locked entry gate through `newEntryGate`. The missing `reshape` is supplied explicitly and vector rotation uses the total `snoc` function.

The earlier linear status model is preserved in `CloneGate/Linear.idr`: fixed-size byte vectors, XOR challenge checking, a license-status decider and state-indexed linear transitions. Its proof/gate constructors stay private, with `newGate` providing a locked gate.

The caller supplies license status and fingerprint. The toy S-box and XOR check are not AES or an authenticated license issuer. A caller can construct its own matching token. The generated payload is four zero bytes; no bank code, repository checkout or hardware payload is attached. Linearity checks apply to linearly bound arguments; this is not persistent single-use storage or replay protection.

The new `decrypt` retains the supplied reverse-key toy transformation; it is not the inverse of `encrypt`. The 4-by-4 fingerprint is 16 bytes, not a SHA-256 digest. Its erased witness proves equality for this function and these inputs, not authentic license ownership. The guarded body currently prints two lines; it does not invoke a banking payload.

The supplied direct-constructor `believe_me` bypass is preserved as `Negative/Bypass.idr` and must fail because constructors are private. Unchecked casts such as `believe_me` can still fabricate abstract values from another module; local `%hide` directives are not a sandbox. This module does not restrict Git or Hugging Face downloads. Public mirrors remain public. An access-controlled deployment needs authenticated license issuance and a server controlling the actual resource.

## Check and run

With Idris 2 0.8.0, in this directory:

```sh
idris2 --total --check CloneGate.idr
idris2 --total --check CloneGate/Linear.idr
idris2 --total -o clone-gate-test Main.idr
build/exec/clone-gate-test
idris2 --total -o attestation-test AttestationSmoke.idr
build/exec/attestation-test
idris2 --build clone-gate.ipkg
build/exec/clone-gate
```

Smoke tests check both models' accepting cases, status rejection in the linear model, fingerprint mismatch and challenge modification. CI also checks that locked/spent gates cannot be cloned, linear arguments cannot be reused, and private constructors cannot be imported.

## File entry point and native launchers

`idris2 --build clone-gate-exe.ipkg` builds `build/exec/clone_gate` with the RefC backend. It accepts exactly `--challenge <16-byte-file> --key <32-byte-file> --expected <32-hex-chars>`. Binary reads reject wrong lengths and truncation, without text decoding or zero padding. The supplied fingerprint must equal the fixed `expectedFP`; a caller cannot select its own successful policy.

Exit codes: 0 accepted and guarded body executed; 1 attestation denied; 2 binary input/runtime failure; 3 malformed arguments or policy fingerprint. The current guarded body prints messages; no banking application is invoked.

`make check` builds the actual Idris CLI and a native shared library exposing `clone_gate_entry`, `clone_gate_init` and `clone_gate_shutdown`. The C ABI uses a shell-free child process, with its executable path pinned at compilation. It does not pretend that guessed RefC runtime hooks or generated symbol names constitute a supported shared-library ABI. Init/shutdown are no-ops for this process bridge. The native test calls the compiled Idris program through the shared library for acceptance, denial, malformed length, policy mismatch and null arguments. This Makefile targets POSIX hosts; Windows code in the C shim requires a Windows build validation.

`matlab/cloneGateMATLAB.m` checks and checks out the MATLAB feature, then delegates to the CLI. Its four arguments are challenge file, key file, expected hex and binary path. Paths containing shell control/expansion characters are rejected. `matlab/CloneGateHeader.ps1` launches licensed MATLAB with noninteractive batch arguments, verifies the signed launcher and owner-signed Idris binary, validates MATLAB's signature, checks three real SHA-256 pins, and rejects paths outside trusted directory boundaries or through reparse points.

The PowerShell launcher requires deployment-specific certificate thumbprint, hashes and trusted roots as mandatory parameters. No example thumbprints or all-zero hashes stand in for a real signed deployment. It returns 4 on launcher validation failures. MATLAB licensing/signing integration cannot be certified without a MATLAB installation, actual license and publisher-signed binaries. Batch mode, execution policy, local signature checks and private Idris constructors do not prevent an administrator or a modified source tree from running alternative code. There is no authentication service in this prototype.
