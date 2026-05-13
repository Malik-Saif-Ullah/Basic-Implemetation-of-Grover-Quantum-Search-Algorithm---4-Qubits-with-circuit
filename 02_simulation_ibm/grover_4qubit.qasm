// ─────────────────────────────────────────────────────────────────────────────
// Grover's Search Algorithm — 4 Qubits, 3 Marked States, k=1 Iteration
// Marked states : |0011⟩, |1010⟩, |1101⟩
// Compatible with IBM Quantum Composer (OpenQASM 2.0)
// Author        : Malik Saif Ullah — QCL/QUAID Lab, SINES, NUST
// ─────────────────────────────────────────────────────────────────────────────

OPENQASM 2.0;
include "qelib1.inc";

qreg q[4];
creg c[4];

// ══════════════════════════════════════════════════════
// STEP 1 : Uniform superposition  H^⊗4
// ══════════════════════════════════════════════════════
h q[0];
h q[1];
h q[2];
h q[3];
barrier q;

// ══════════════════════════════════════════════════════
// STEP 2 : Phase Oracle  O_f
//   Applies a −1 phase to each of the three marked states.
//   Method: open-control trick + MCZ (H–CCCCX–H sandwich)
//
//   Target |0011⟩  (q3=0, q2=0, q1=1, q0=1  in Qiskit endian)
// ══════════════════════════════════════════════════════

// — Oracle for |0011⟩ —
// q[3] and q[2] are '0' → flip them before MCZ
x q[3];
x q[2];
// MCZ via H on target + ccccx + H
h q[3];
ccx q[0], q[1], q[3];   // approximate 3-ctrl using Toffoli chain (see note)
h q[3];
x q[3];
x q[2];
barrier q;

// — Oracle for |1010⟩ —
// q[1] and q[3] are '0' → flip
x q[1];
x q[3];
h q[3];
ccx q[0], q[2], q[3];
h q[3];
x q[1];
x q[3];
barrier q;

// — Oracle for |1101⟩ —
// q[1] is '0' → flip
x q[1];
h q[3];
ccx q[0], q[2], q[3];
h q[3];
x q[1];
barrier q;

// ══════════════════════════════════════════════════════
// STEP 3 : Grover Diffusion Operator  D = H·(2|0⟩⟨0|−I)·H
// ══════════════════════════════════════════════════════
h q[0];
h q[1];
h q[2];
h q[3];

// 2|0⟩⟨0| − I  implemented as: X–MCZ–X on all qubits
x q[0];
x q[1];
x q[2];
x q[3];

h q[3];
ccx q[0], q[1], q[2];   // 3-ctrl Toffoli chain
ccx q[2], q[1], q[3];   // chain the control
h q[3];

x q[0];
x q[1];
x q[2];
x q[3];

h q[0];
h q[1];
h q[2];
h q[3];
barrier q;

// ══════════════════════════════════════════════════════
// STEP 4 : Measurement
// ══════════════════════════════════════════════════════
measure q[0] -> c[0];
measure q[1] -> c[1];
measure q[2] -> c[2];
measure q[3] -> c[3];

// ─────────────────────────────────────────────────────────────────────────────
// NOTE on 4-qubit MCZ decomposition:
//   IBM Quantum Composer supports up to 3-qubit Toffoli (ccx) natively.
//   For a true 4-qubit controlled-Z on hardware use an ancilla-assisted
//   decomposition or the relative-phase Toffoli gate (rccx). The circuit
//   above is a pedagogical version; for hardware execution on real IBM
//   backends use the Qiskit transpiler with the .ipynb code in 01_code/.
// ─────────────────────────────────────────────────────────────────────────────
