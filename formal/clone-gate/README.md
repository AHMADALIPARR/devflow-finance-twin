<!-- SPDX-License-Identifier: LicenseRef-Sovereign-Leviathan-SL-AGPL3-001 -->
# Idris clone gate

The supplied clone-gate model is implemented in `CloneGate.idr`: fixed-size byte vectors, XOR challenge checking, a license-status decider, state-indexed gate transitions and linear function arguments. Constructors for `LicenseProof` and `CloneGate` stay private to the module; callers can obtain a locked gate through `newGate`.

The caller supplies license status and fingerprint. The toy S-box and XOR check are not AES or an authenticated license issuer. A caller can construct its own matching token. The generated payload is four zero bytes; no bank code, repository checkout or hardware payload is attached. Linearity checks apply to linearly bound arguments; this is not persistent single-use storage or replay protection.

This module does not restrict Git or Hugging Face downloads. Public mirrors remain public. A real access-controlled deployment needs authenticated license issuance and a server that controls the actual resource; those are outside this model.

## Check and run

With Idris 2 0.8.0, in this directory:

```sh
idris2 --total --check CloneGate.idr
idris2 --total --check Main.idr
idris2 --total -o clone-gate-test Main.idr
build/exec/clone-gate-test
```

The smoke test checks acceptance, trial/expired rejection, fingerprint mismatch and a modified challenge. CI also checks that locked/spent gates cannot be cloned, linear arguments cannot be reused, and private constructors cannot be imported.
