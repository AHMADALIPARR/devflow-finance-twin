<!-- SPDX-License-Identifier: LicenseRef-Sovereign-Leviathan-SL-AGPL3-001 -->
# Holographic CloneGate model

Serve this directory over HTTP and open index.html. No GPU renderer or model server is used. Canvas2D displays a fixed 320×160 framebuffer computed by hologram.wat at ten frames per second plus a projected wireframe cube. Motion pauses when the page is hidden; reduced-motion settings start it paused.

Compile with an installed wabt package:

    node build.cjs <absolute-path-to-wabt>
    node test.cjs
    node --check app.js

The browser uses public all-zero demo key/challenge bytes and a sixteen-byte 0e fingerprint. Its check implements the supplied Idris toy transform: reverse the 32-byte key, initial XOR, fourteen increment/row-shift/rotated-key-XOR rounds. This is not AES-256, a decryption inverse, a secret-bearing license system, or browser access enforcement. The negative-check button changes the expected fingerprint and shows the actual WAT denial.

The supplied shader inspired the palette, interference, scanlines, frame and cube. This bounded CPU implementation does not execute the GLSL shader or incomplete Forth/assembly snippets. WAT source and generated WASM are included; the binary has an adjacent Covenant SPDX notice.
