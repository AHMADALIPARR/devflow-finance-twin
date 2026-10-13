// SPDX-License-Identifier: LicenseRef-Sovereign-Leviathan-SL-AGPL3-001
const canvas = document.querySelector('#field');
const ctx = canvas.getContext('2d', {alpha:false});
const status = document.querySelector('#status');
const pause = document.querySelector('#pause');
const check = document.querySelector('#check');
const reduced = matchMedia('(prefers-reduced-motion: reduce)');
let paused = reduced.matches, timer = null, wasm, pixels;
const vertices = [[-1,-1,-1],[1,-1,-1],[1,1,-1],[-1,1,-1],[-1,-1,1],[1,-1,1],[1,1,1],[-1,1,1]];
const edges = [[0,1],[1,2],[2,3],[3,0],[4,5],[5,6],[6,7],[7,4],[0,4],[1,5],[2,6],[3,7]];
function draw(t){
  wasm.render(320,160,t);
  ctx.putImageData(pixels,0,0);
  const a=t*.4, c=Math.cos(a), s=Math.sin(a);
  const projected=vertices.map(([x,y,z])=>{const rx=x*c-z*s,rz=x*s+z*c;return [160+rx/(rz+3)*90,80+y/(rz+3)*90];});
  ctx.strokeStyle='#72ffff';ctx.lineWidth=1;ctx.beginPath();
  for(const [a,b] of edges){ctx.moveTo(...projected[a]);ctx.lineTo(...projected[b]);}ctx.stroke();
  ctx.strokeStyle='#ff3ba7';ctx.globalAlpha=.5;ctx.strokeRect(12,12,296,136);ctx.globalAlpha=1;
}
function schedule(){
  clearTimeout(timer);timer=null;
  if(!wasm||document.hidden)return;
  draw(performance.now()/1000);
  if(!paused)timer=setTimeout(schedule,100); // 10fps, fixed 320x160 CPU budget.
}
function label(){pause.textContent=paused?'Resume motion':'Pause motion';pause.setAttribute('aria-pressed',String(paused));}
pause.addEventListener('click',()=>{paused=!paused;label();schedule();});
reduced.addEventListener('change',()=>{paused=reduced.matches;label();schedule();});
document.addEventListener('visibilitychange',schedule);
function runCheck(negative){
  const bytes=new Uint8Array(wasm.memory.buffer);bytes.fill(0,0,48);bytes.fill(14,48,64);
  if(negative)bytes[48]=15;
  const pass=wasm.attest()===1;
  status.textContent=pass?'MODEL CHECK PASSED // WAT':'MODEL CHECK DENIED // WAT';
}
check.addEventListener('click',()=>{const negative=check.textContent==='Run negative check';runCheck(negative);check.textContent=negative?'Restore demo check':'Run negative check';});
try{
  if(!ctx)throw new Error('Canvas2D unavailable');
  const response=await fetch('hologram.wasm');if(!response.ok)throw new Error(`WASM HTTP ${response.status}`);
  ({instance:{exports:wasm}}=await WebAssembly.instantiate(await response.arrayBuffer(),{math:{sin:Math.sin,cos:Math.cos}}));
  pixels=new ImageData(new Uint8ClampedArray(wasm.memory.buffer,1024,320*160*4),320,160);
  runCheck(false);pause.disabled=false;check.disabled=false;label();schedule();
}catch(error){status.textContent='MODEL UNAVAILABLE // '+error.message;}
