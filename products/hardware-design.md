# Hardware and Semiconductor Kit

VHDL transformer RTL, SoC dossier, VSM2500 and GPU fabric sources.

Audience: Hardware research engineers.

Source roots:

- `semiconductor`
- `vsm2500`
- `gpu`
- `languages/ptx`

Dependencies: formal-assurance.

Package from the repository root:

```powershell
python scripts/product_suite.py bundle hardware-design
```

Release gates:

- Run HDL simulation, synthesis and timing/resource reports
- Physical design and manufacturing docs are not fabricated silicon evidence
- CUDA/H100 execution is not validated on this machine
