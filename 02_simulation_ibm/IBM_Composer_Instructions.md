# IBM Quantum Composer Simulation Guide

## How to Load `grover_4qubit.qasm` in IBM Quantum Composer

### Step 1 — Open IBM Quantum Composer
Go to [https://quantum.ibm.com/composer](https://quantum.ibm.com/composer) and log in (free account).

### Step 2 — Import the QASM File
1. Click **"New File"** or open an existing project.
2. In the top menu, click **"File → Import QASM"** (or paste directly into the QASM editor tab).
3. Select `grover_4qubit.qasm` from `02_simulation_ibm/`.

### Step 3 — Run Statevector Simulation
1. In the **right panel**, select **"Statevector Simulator"**.
2. Set **shots = 8192** for statistical accuracy.
3. Click **"Run"**.

### Step 4 — Expected Results
After 1 Grover iteration (k=1), the three marked states should dominate the measurement histogram:

| State   | Theory Prob | Expected Counts (8192 shots) |
|---------|-------------|------------------------------|
| `|0011⟩` | ~0.3164    | ~2592                        |
| `|1010⟩` | ~0.3164    | ~2592                        |
| `|1101⟩` | ~0.3164    | ~2592                        |
| All others | ~0.0033 | ~5 each                      |

**Total success probability: ~94.9%** (vs 18.75% uniform random)

### Step 5 — Compare with Qiskit Simulation
Run the Jupyter notebook in `01_code/grover_4qubit.ipynb` for full Qiskit AerSimulator results, circuit diagrams, and the quantum advantage plot.

---

## Circuit Architecture Overview

```
q[0]: ─H──[Oracle: O_f]──[Diffusion: D]──M
q[1]: ─H──[Oracle: O_f]──[Diffusion: D]──M
q[2]: ─H──[Oracle: O_f]──[Diffusion: D]──M
q[3]: ─H──[Oracle: O_f]──[Diffusion: D]──M
```

| Block         | Gate count | Role                                  |
|---------------|-----------|---------------------------------------|
| Superposition | 4 H gates | Creates uniform `|ψ⟩ = 1/4 Σ|x⟩`    |
| Oracle O_f    | ~30 gates | Flips phase of `|0011⟩, |1010⟩, |1101⟩` |
| Diffusion D   | ~20 gates | Reflects about mean amplitude         |
| Measurement   | 4         | Collapses to classical bitstring      |

---

> **Note on Hardware Execution**: For running on real IBM quantum hardware (e.g., ibm_brisbane, ibm_kyiv), use the Qiskit notebook which handles noise-aware transpilation via the Qiskit transpiler. Real hardware results will show higher noise in non-target states but the marked states should still peak significantly above the baseline.
