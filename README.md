# DDM501 – Individual Assignment 1: ML System Design Document

**Topic:** Real-time transaction fraud detection for a mobile e-wallet (hypothetical company "WalletCo", Vietnam).

📄 **Report (PDF):** [DDM501_Assignment1_StudentID_Name.pdf](DDM501_Assignment1_StudentID_Name.pdf)

## Report structure (follows the assignment brief)

| Section | Weight | Content |
|---|---|---|
| 1. Problem definition | 20% | Context, measurable problem statement, current rule-engine process, why ML, 8 stakeholders and their concerns |
| 2. Requirements analysis | 20% | Functional (FR-1…FR-7, I/O spec, integrations, user interaction), non-functional (latency, scalability, reliability, maintainability), data (sources, quality, privacy, volume) |
| 3. Goals and metrics | 20% | Goal hierarchy (business → system → model), metrics, baselines and launch thresholds |
| 4. High-level architecture | 25% | Architecture diagram (online / streaming / offline planes), data flow, ML pipeline stages, component table with technology choices |
| 5. Trade-off analysis | 15% | Accuracy vs. latency, freshness vs. cost, simplicity vs. performance, automation vs. control, privacy vs. personalisation |
| 6–7. Risks, rollout, conclusion | – | Risks and mitigations, 6-month rollout plan |

## Key design points

- **Model:** one LightGBM classifier (~120 tabular features), calibrated, with TreeSHAP reason codes.
- **Decision:** cost-based policy → ALLOW / CHALLENGE (OTP) / REVIEW / BLOCK; hard rules first; rule engine kept as fallback.
- **Latency:** p99 ≤ 100 ms inside a 300 ms payment budget.
- **Features:** Flink streaming velocity features (≤ 5 s) + daily batch features, shared through Feast (Redis online, Parquet offline).
- **MLOps:** Airflow weekly retraining, MLflow registry, shadow → canary → production, Prometheus/Grafana + Evidently monitoring.
- **Targets:** fraud loss 6 → 3 bps of GMV, false declines 1.2% → 0.5%, review queue −66%.

## Build the PDF

The report source is [`report/report.html`](report/report.html) (diagrams are inline SVG). Render it with headless Chrome:

```bash
./build_pdf.sh                                         # → DDM501_Assignment1_StudentID_Name.pdf
./build_pdf.sh DDM501_Assignment1_<ID>_<Name>.pdf      # custom file name
```
