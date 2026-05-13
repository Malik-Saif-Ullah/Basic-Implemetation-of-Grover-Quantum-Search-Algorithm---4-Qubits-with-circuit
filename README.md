<div align="center">

<img src="https://img.shields.io/badge/Qiskit-2.1%2B-6929C4?style=for-the-badge&logo=ibm&logoColor=white"/>
<img src="https://img.shields.io/badge/Python-3.9%2B-3776AB?style=for-the-badge&logo=python&logoColor=white"/>
<img src="https://img.shields.io/badge/IBM%20Quantum-OpenQASM%202.0-054ADA?style=for-the-badge&logo=ibm&logoColor=white"/>
<img src="https://img.shields.io/badge/Qubits-4-blueviolet?style=for-the-badge"/>
<img src="https://img.shields.io/badge/Speedup-×4.25-brightgreen?style=for-the-badge"/>

<br/><br/>

# ⚛️ Grover's Quantum Search Algorithm
### 4-Qubit Implementation · 3 Marked States · Optimal k=1 Iteration

*A complete, reproducible implementation of Grover's unstructured quantum search algorithm on a 4-qubit system with full Qiskit simulation, IBM Quantum Composer QASM export, and theoretical analysis.*

**Author:** Malik Saif Ullah · QCL/QUAID Lab, SINES, NUST, Islamabad  
**Course:** Quantum Computing & Information — MS Computational Science & Engineering, NUST

---

</div>

## 📋 Table of Contents

- [Overview](#-overview)
- [Theoretical Background](#-theoretical-background)
- [Repository Structure](#-repository-structure)
- [Quick Start](#-quick-start)
- [Circuit Architecture](#-circuit-architecture)
- [Results](#-results)
- [IBM Quantum Composer](#-ibm-quantum-composer)
- [References](#-references)

---

## 🔭 Overview

Grover's algorithm [[Grover, 1996]](#-references) is the **optimal quantum algorithm for unstructured search**. Given a black-box oracle that marks $M$ target states in a space of $N = 2^n$ elements, it finds a solution in:

$$k_{\text{opt}} = \left\lfloor \frac{\pi}{4} \cdot \frac{1}{\arcsin\!\sqrt{M/N}} \right\rfloor \text{ oracle calls}$$

versus the classical lower bound of $O(N/M)$ calls — a **quadratic speedup**.

### This Implementation at a Glance

| Parameter | Value |
|-----------|-------|
| Qubits $n$ | **4** |
| Search space $N = 2^n$ | **16 states** |
| Marked states $M$ | **3** → `\|0011⟩`, `\|1010⟩`, `\|1101⟩` |
| Optimal iterations $k$ | **1** |
| Grover angle $\theta$ | **0.4478 rad** |
| Theory $P(\text{success})$ | **94.92%** |
| Simulation $P(\text{success})$ | **94.48%** *(8,192 shots)* |
| Quantum Speedup | **×4.25** |

---

## 📐 Theoretical Background

### The Search Problem

Given a function $f : \{0,1\}^n \to \{0,1\}$ where $f(x) = 1$ for exactly $M$ "marked" states, find any $x^*$ such that $f(x^*) = 1$.

**Classical:** Expected $\frac{N+1}{M+1}$ queries for random sampling without replacement.  
**Quantum (Grover):** $O\!\left(\sqrt{N/M}\right)$ oracle calls.

### Algorithm Steps

```
┌─────────────────────────────────────────────────────────────────┐
│                     GROVER'S ALGORITHM                          │
├─────────────────────────────────────────────────────────────────┤
│  1. INIT    Apply H⊗ⁿ to |0...0⟩ → uniform superposition |ψ⟩  │
│                                                                   │
│             |ψ⟩ = 1/√N · Σ|x⟩   for x ∈ {0,1}ⁿ               │
│                                                                   │
│  2. ORACLE  Apply O_f : |x⟩ → (−1)^f(x)|x⟩                    │
│             Phase-flip the marked states                          │
│                                                                   │
│  3. DIFFUSE Apply D = H·(2|0⟩⟨0|−I)·H  (Grover diffusion)     │
│             Reflect about the mean amplitude                      │
│                                                                   │
│  4. REPEAT  Steps 2–3  for  k_opt  iterations                    │
│                                                                   │
│  5. MEASURE Collapse → marked state with P ≈ sin²((2k+1)θ)     │
└─────────────────────────────────────────────────────────────────┘
```

### Success Probability

After $k$ iterations:

$$P(\text{success}) = \sin^2\!\bigl((2k+1)\theta\bigr), \quad \theta = \arcsin\!\sqrt{\frac{M}{N}}$$

For this experiment: $\theta = \arcsin\!\sqrt{3/16} = 0.4478\ \text{rad}$, $k=1$:

$$P(\text{success}) = \sin^2(3 \times 0.4478) = \sin^2(1.3435) \approx \mathbf{0.9492}$$

### The Phase Oracle

For each target bitstring $t$, the oracle applies:

1. **Open-control trick**: Apply $X$ to qubit $j$ wherever $t_j = 0$
2. **Multi-controlled Z** via $H \cdot \text{MCX} \cdot H$ sandwich on the last qubit
3. **Undo** the $X$ gates

This marks exactly $|t\rangle$ with a $-1$ phase flip.

---

## 🗂️ Repository Structure

```
Basic-Implementation-of-Grover-Quantum-Search-Algorithm-4-Qubits/
│
├── 📓 01_code/
│   ├── grover_4qubit.ipynb       # Main Jupyter notebook (Qiskit + AerSimulator)
│   └── requirements.txt          # Python dependencies
│
├── 🖥️ 02_simulation_ibm/
│   ├── grover_4qubit.qasm        # OpenQASM 2.0 circuit for IBM Quantum Composer
│   └── IBM_Composer_Instructions.md   # Step-by-step IBM simulation guide
│
├── 📊 03_results/
│   ├── Results_Summary.md        # Full numerical results table
│   ├── grover_circuit.jpg        # Circuit diagram (generated by notebook)
│   └── grover_histogram.jpg      # Probability histogram + speedup plot (generated)
│
├── 📄 04_report/
│   └── Grover_Project_Report.docx  # Full written project report
│
├── .gitignore
└── README.md                     # ← You are here
```

---

## 🚀 Quick Start

### Prerequisites

```bash
pip install "qiskit>=2.1" qiskit-aer matplotlib numpy
```

Or install from the requirements file:

```bash
pip install -r 01_code/requirements.txt
```

### Run the Notebook

```bash
jupyter notebook 01_code/grover_4qubit.ipynb
```

Run all cells. The notebook will:
1. Build the phase oracle for targets `|0011⟩`, `|1010⟩`, `|1101⟩`
2. Construct the full Grover circuit (1 iteration)
3. Simulate on `AerSimulator` with 8,192 shots
4. Print the results summary to console
5. Save `grover_circuit.jpg` and `grover_histogram.jpg` to `03_results/`

### Expected Console Output

```
Building oracle for targets ['0011', '1010', '1101']  (n=4, N=16, M=3, k=1)
Building full Grover circuit
  Gate count  : 54
  Circuit depth: 20
Running simulation on AerSimulator

Results Summary

  Qubits n        : 4
  Search space N  : 16
  Marked states M : 3  ['0011', '1010', '1101']
  Grover angle θ  : 0.447832 rad
  Optimal iter. k : 1

  Theory  P(success) = sin²((2k+1)θ) = 0.94922
  Sim.    P(success)                 = 0.94482  (8,192 shots)
  Theory  P(per target)              = 0.31641

  Per-target counts:
    |0011⟩   2597 shots  (0.3170)
    |1010⟩   2624 shots  (0.3203)
    |1101⟩   2519 shots  (0.3075)

  Classical queries : 4.25
  Grover oracle calls        : 1
  Quantum speedup            : ×4.25
```

---

## 🔌 Circuit Architecture

### High-Level Structure

```
       ┌───┐ ░ ┌────────────────────────────────────────────┐ ░ ┌─┐
q[0]:  ┤ H ├─░─┤                                            ├─░─┤M├
       ├───┤ ░ │                                            │ ░ └─┘
q[1]:  ┤ H ├─░─┤     Grover Operator Q = D · O_f           ├─░─┤M├
       ├───┤ ░ │         (applied k=1 times)               │ ░ └─┘
q[2]:  ┤ H ├─░─┤                                            ├─░─┤M├
       ├───┤ ░ │                                            │ ░ └─┘
q[3]:  ┤ H ├─░─┤                                            ├─░─┤M├
       └───┘ ░ └────────────────────────────────────────────┘ ░ └─┘
             Superposition           Q¹                      Measure
```

### Inside the Grover Operator Q

| Sub-circuit | Components | Role |
|-------------|------------|------|
| **Oracle** $\mathcal{O}_f$ | X, H, MCX, H, X gates (×3 targets) | $\|x\rangle \to (-1)^{f(x)}\|x\rangle$ |
| **Diffusion** $\mathcal{D}$ | H⁴, X⁴, Multi-CZ, X⁴, H⁴ | Reflect about $\|\psi\rangle$ |

### Gate Counts

| Stage | Gate Count | Depth Contribution |
|-------|------------|-------------------|
| Superposition (H⁴) | 4 | 1 |
| Oracle (3 targets) | ~30 | 12 |
| Diffusion | ~16 | 6 |
| Measurement | 4 | 1 |
| **Total** | **54** | **20** |

---

## 📊 Results

### Simulation vs Theory Comparison

| State | Sim Counts | Sim Prob | Theory Prob | Deviation |
|-------|-----------|----------|-------------|-----------|
| `\|0011⟩` | 2,597 | 0.3170 | 0.3164 | +0.19% |
| `\|1010⟩` | 2,624 | 0.3203 | 0.3164 | +1.23% |
| `\|1101⟩` | 2,519 | 0.3075 | 0.3164 | −2.81% |
| **Σ marked** | **7,740** | **0.9448** | **0.9492** | **−0.46%** |
| Each unmarked | ~22 | ~0.0027 | ~0.0033 | — |

> 📌 The simulation is in excellent agreement with theory — all deviations are within expected statistical noise for 8,192 shots.

### Quantum Advantage

```
Oracle Queries to Find a Solution
──────────────────────────────────
Classical Random Search:   ████████████████████  4.25 queries  O(N/M)
Grover's Algorithm:        ████  1 oracle call   O(√(N/M))
                                          ─────
                                  Speedup: ×4.25
```

For larger $n$, the speedup grows as $\sqrt{N/M}$:

| $n$ | $N$ | $M$ | Classical | Grover | Speedup |
|-----|-----|-----|-----------|--------|---------|
| 4   | 16  | 3   | 4.25      | 1      | ×4.25   |
| 8   | 256 | 3   | 64.25     | 7      | ×9.18   |
| 16  | 65,536 | 3 | 16,384 | 128    | ×128    |
| 20  | 1,048,576 | 1 | 524,288 | 805 | ×652   |

---

## 🖥️ IBM Quantum Composer

The file `02_simulation_ibm/grover_4qubit.qasm` is ready to import into [IBM Quantum Composer](https://quantum.ibm.com/composer).

### Quick Steps

1. Go to [quantum.ibm.com/composer](https://quantum.ibm.com/composer)
2. Click **File → Import QASM**
3. Upload `02_simulation_ibm/grover_4qubit.qasm`
4. Select **Statevector Simulator**, set **shots = 8192**
5. Click **Run** → observe the three marked states dominate

See [`02_simulation_ibm/IBM_Composer_Instructions.md`](02_simulation_ibm/IBM_Composer_Instructions.md) for detailed instructions and expected output.

> **Hardware Note**: For real IBM quantum backends (e.g., `ibm_brisbane`), use the Qiskit notebook with noise-aware transpilation. The QASM file uses Toffoli gate decompositions that the transpiler can map to native gate sets.

---

## 📚 References

1. **Grover, L. K.** (1996). A fast quantum mechanical algorithm for database search. *Proceedings of STOC*, 212–219. [arXiv:quant-ph/9605043](https://arxiv.org/abs/quant-ph/9605043)

2. **Nielsen, M. A. & Chuang, I. L.** (2010). *Quantum Computation and Quantum Information* (10th anniversary ed.). Cambridge University Press. §6.1 – The quantum search algorithm.

3. **Boyer, M., Brassard, G., Høyer, P., & Tapp, A.** (1998). Tight bounds on quantum searching. *Fortschritte der Physik*, 46(4–5), 493–505. [arXiv:quant-ph/9605034](https://arxiv.org/abs/quant-ph/9605034) — Optimal iteration count derivation.

4. **Qiskit Contributors** (2024). *Qiskit: An Open-source Framework for Quantum Computing*. [https://qiskit.org](https://qiskit.org) — `grover_operator`, `AerSimulator`.

5. **IBM Quantum** (2024). IBM Quantum Composer Documentation. [https://quantum.ibm.com/docs](https://quantum.ibm.com/docs)

---

<div align="center">

**Made with ⚛️ at QCL/QUAID Lab · SINES · NUST Islamabad**

*If you find this useful, consider starring ⭐ the repository.*

</div>
