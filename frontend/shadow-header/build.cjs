// SPDX-License-Identifier: LicenseRef-Sovereign-Leviathan-SL-AGPL3-001
// node build.cjs <path-to-installed-wabt>
const fs=require('node:fs');const path=require('node:path');
(async()=>{const wabt=await require(process.argv[2]||'wabt')();const source=fs.readFileSync(path.join(__dirname,'hologram.wat'),'utf8');const module=wabt.parseWat('hologram.wat',source);module.resolveNames();module.validate();fs.writeFileSync(path.join(__dirname,'hologram.wasm'),Buffer.from(module.toBinary({canonicalize_lebs:true}).buffer));module.destroy();})();
