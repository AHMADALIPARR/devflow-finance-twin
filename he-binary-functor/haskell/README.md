<!--
License-ID: SL-AGPL3-001 | Covenant-Version: 1.0 | Project policy reference
SPDX-License-Identifier: LicenseRef-Sovereign-Leviathan-SL-AGPL3-001
Main project policy: LICENSES/LicenseRef-Sovereign-Leviathan-SL-AGPL3-001.txt.
Existing file, component and third-party notices and grants are preserved.
-->

# haskell

**Haskell Modules** — Workerman calculus, CLI ISA, and Spherical Geometry Language.

## Subdirectories

| Directory | Language | Description |
|-----------|----------|-------------|
| [Workerman/](Workerman/) | Haskell | Calculus module |

## Files at Root

| File | Language | Description |
|------|----------|-------------|
| `CliIsa.hs` | Haskell | CLI ISA specification |
| `SGL.hs` | Haskell | Spherical Geometry Language |

## Workerman

```haskell
module Workerman.Calculus where
-- Calculus operations for binary functor
```

## Build

```bash
ghc CliIsa.hs
ghc SGL.hs
cd Workerman && ghc Calculus.hs
```