# Benchmark protocol

## Evidence rules

Pin source revision, command, interpreter/compiler versions, platform, CPU, workload, input origin, repetitions, correctness checks, timing boundaries and failures. Performance rows without preserved-record count and valid chain are invalid. Report failures as failures rather than replacing inputs or silently excluding slow trials. Synthetic local fixture data are not financial observations.

## Executed WORM workload

Python standard library `perf_counter_ns` measures each `WormStorageEngine.append`. Each record has integer `sequence` and a 512-character ASCII `data` field. Each trial uses a fresh OS temporary directory. For sizes 100 and 250, discard one warmup and retain five trials. Append latency includes serialization, hashing, file reads, text writes, `fsync` and replacement; initialization and subsequent verification are outside the timed span. Report total time, median per-call time and nearest-rank p95 per trial. This measures growing-file behavior, not a stationary single-record latency.

After every trial require exactly N records and a successful `verify_integrity`. No physical disk cache reset, CPU pinning, idle-host guarantee or independent process concurrency workload was applied. Runs shared this workstation with ordinary activity and other validation. Results cannot establish production throughput, crash durability, multi-process safety or hardware WORM compliance.

The [evidence JSON](benchmark-results.json) contains all retained trials. The temporary driver is transcribed below for reproduction; it is documentation, not a repository runtime or glue script.

## Correctness matrix and commands

| Component | Command | Gate |
|---|---|---|
| Finance/audit fixtures | `python -B -m unittest discover -s tests -v` | All assertions; inspect fixture scope |
| Quantum simulator checks | `python -B quantum_computer/tests/test_full.py` (also `test_simulator.py`, `test_extended.py`) | Script pass/fail counters and exit code; `PYTHONPATH` repository root |
| FSL | `cargo test --manifest-path rust/fsl/Cargo.toml --locked --target-dir <external-temp-path>` | Compile first, then tests; a compile failure is blocked evidence |
| Formal systems | Component-specific pinned compiler/checker commands required | No admissions, or explicit assumption classification and bounded claims |
| Native language families | Component-specific native build and semantic tests required | No successful integration inferred from extensions |

## Next benchmarks

After correctness blockers are fixed under separate scope: native POSIX WORM and Windows; concurrent independent writers; interruption/recovery and size-boundary tests; replay throughput and memory versus event count; cryptographic test vectors before timing; quantum numerical comparison with pinned Aer version and identical circuits; FSL backend satisfiability equivalence before timings; native COBOL/PL/I/RPG/assembly compiler acceptance. Record comparative inputs and versions, not benchmark marketing claims.

## Controlled LF experiment

On this Windows host, intercept only Python text write calls in a temporary test fixture and specify `newline="\n"`. Original source and method bodies remain unchanged. Append two payloads and read/verify the resulting log. This emulates LF text-write sizes; it is not a native Linux run or a committed fix. The storage method compares temporary-file byte size to the LF-encoded new-record size before deciding whether to retain existing content. A failed experiment blocks a universal append-only claim; verify on native POSIX before finalizing platform coverage.

## Reproduction driver

Run this transcribed Python code from the repository root with `python -B`; it writes only OS temporary fixture files and a temporary JSON result. Create the output temporary directory first.

```python
import sys,json,time,tempfile,statistics,platform,builtins
from pathlib import Path
from unittest.mock import patch
sys.path.insert(0,str(Path.cwd()))
from src.worm import WormStorageEngine
out=Path(tempfile.gettempdir())/'devflow-docs-289e058'
results={'source_commit':'289e05876f15965a95f990ed178961aee0ebcb73','python':platform.python_version(),'platform':platform.platform(),'workload':'synthetic 512-character ASCII data field plus integer sequence; local tempfile; fsync included','warmups_per_size':1,'measured_trials_per_size':5,'trials':[]}
for n in (100,250):
 for trial in range(6):
  with tempfile.TemporaryDirectory() as d:
   engine=WormStorageEngine(str(Path(d)/'bench.worm'))
   lat=[]
   for i in range(n):
    t=time.perf_counter_ns();engine.append({'sequence':i,'data':'x'*512});lat.append((time.perf_counter_ns()-t)/1e6)
   valid,error=engine.verify_integrity(); count=len(engine.read_all())
   if trial:
    results['trials'].append({'records':n,'trial':trial,'total_append_ms':sum(lat),'median_append_ms':statistics.median(lat),'p95_append_ms':sorted(lat)[__import__('math').ceil(.95*n)-1],'records_read':count,'chain_valid':valid,'error':error})
real_open=builtins.open
def lf_open(*args,**kwargs):
 mode=args[1] if len(args)>1 else kwargs.get('mode','r')
 if 'b' not in mode and any(x in mode for x in ('w','a')):kwargs.setdefault('newline','\n')
 return real_open(*args,**kwargs)
with tempfile.TemporaryDirectory() as d:
 with patch('builtins.open',lf_open):
  engine=WormStorageEngine(str(Path(d)/'lf.worm'));engine.append({'sequence':1});engine.append({'sequence':2})
  valid,error=engine.verify_integrity(); count=len(engine.read_all())
 results['lf_experiment']={'host':'Windows; controlled LF text-write experiment, not native POSIX execution','expected_records':2,'observed_records':count,'chain_valid':valid,'error':error,'source_modified':False}
(out/'benchmark-results.json').write_text(json.dumps(results,indent=2),encoding='utf-8')
print(json.dumps(results,indent=2))
```
