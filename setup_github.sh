#!/bin/bash
# ─────────────────────────────────────────────────────────────────────────────
# setup_github.sh
# Run this script ONCE from inside the repo folder to push everything to GitHub.
# Prerequisites: git installed, GitHub account authenticated (SSH or HTTPS token)
# ─────────────────────────────────────────────────────────────────────────────

REPO_URL="https://github.com/Malik-Saif-Ullah/Basic-Implemetation-of-Grover-Quantum-Search-Algorithm---4-Qubits-with-circuit.git"

echo "🔧 Initializing git repo..."
git init

echo "📂 Staging all files..."
git add .

echo "✅ Creating initial commit..."
git commit -m "feat: initial commit — Grover 4-qubit implementation with Qiskit, QASM, results, and report

- 01_code/ : Jupyter notebook (grover_4qubit.ipynb) + requirements.txt
- 02_simulation_ibm/ : OpenQASM 2.0 circuit + IBM Composer instructions  
- 03_results/ : Results summary (theory vs simulation)
- 04_report/ : Full written project report (.docx)
- README.md  : Interactive README with theory, circuit diagrams, results table"

echo "🔗 Setting remote origin..."
git remote add origin "$REPO_URL"

echo "🚀 Pushing to GitHub..."
git branch -M main
git push -u origin main

echo ""
echo "✅ Done! Visit your repo at:"
echo "   https://github.com/Malik-Saif-Ullah/Basic-Implemetation-of-Grover-Quantum-Search-Algorithm---4-Qubits-with-circuit"
