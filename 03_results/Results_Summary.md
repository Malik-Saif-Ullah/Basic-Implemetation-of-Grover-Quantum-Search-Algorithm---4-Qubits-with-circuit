# Simulation Results — Grover's Algorithm (4 Qubits)

## Run Configuration

| Parameter           | Value                       |
|---------------------|-----------------------------|
| Qubits (n)          | 4                           |
| Search space (N)    | 16 states                   |
| Marked states (M)   | 3 → `|0011⟩`, `|1010⟩`, `|1101⟩` |
| Grover iterations (k) | 1 (optimal)               |
| Shots               | 8,192                       |
| Simulator           | Qiskit AerSimulator (statevector) |

---

## Theoretical Analysis

| Quantity                         | Value             |
|----------------------------------|-------------------|
| Grover rotation angle θ          | 0.447832 rad      |
| Optimal iteration count k        | 1                 |
| Theory P(success) = sin²((2k+1)θ) | **0.94922**      |
| Theory P(per target)             | 0.31641           |
| Uniform random baseline (1/N)    | 0.0625            |
| Amplification factor per target  | **~5.06×**        |

---

## Simulation Results

| Metric                     | Value          |
|----------------------------|----------------|
| Simulated P(success)       | **0.94482**    |
| Theory vs Sim deviation    | 0.44%          |
| Classical queries expected | 4.25           |
| Grover oracle calls        | 1              |
| **Quantum Speedup**        | **×4.25**      |

### Per-Target Measurement Counts

| State    | Counts | Probability | Theory |
|----------|--------|-------------|--------|
| `\|0011⟩` | 2,597  | 0.3170      | 0.3164 |
| `\|1010⟩` | 2,624  | 0.3203      | 0.3164 |
| `\|1101⟩` | 2,519  | 0.3075      | 0.3164 |
| **Total** | **7,740** | **0.9448** | **0.9492** |

---

## Circuit Metrics

| Metric         | Value |
|----------------|-------|
| Gate count     | 54    |
| Circuit depth  | 20    |

---

## Output Figures

> Place the generated figures here after running the notebook.

| File                    | Description                                    |
|-------------------------|------------------------------------------------|
| `grover_circuit.jpg`    | Full circuit diagram (decomposed one level)    |
| `grover_histogram.jpg`  | Probability histogram + quantum advantage plot |

**Add your generated figures to this folder** by running `01_code/grover_4qubit.ipynb`.
The notebook saves `grover_circuit.jpg` and `grover_histogram.jpg` automatically.

---

## Key Takeaway

With just **k = 1 oracle call**, Grover's algorithm finds one of 3 marked states among 16 with **94.9% probability** — versus the ~18.8% expected from a classical random guess, and the ~73.5% expected after the classical average of 4.25 queries.
