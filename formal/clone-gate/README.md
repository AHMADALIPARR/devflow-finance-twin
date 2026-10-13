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
