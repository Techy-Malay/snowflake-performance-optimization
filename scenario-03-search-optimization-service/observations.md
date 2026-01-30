# Observations — Search Optimization Service (SOS)

- SOS is a **distance optimization** technique.
- Distance refers to **bytes scanned and data traversal**.
- SOS does **not** optimize CPU-heavy work such as joins or aggregations.

- SOS usage is **cost-based**.
- Enabling SOS does not guarantee it will be used.

- On smaller tables (ORDERS), the optimizer may prefer a table scan.
- On larger tables (LINEITEM), SOS can eliminate micro-partition scans.

- SOS usage is inferred indirectly:
  - TableScan cost collapses to near zero
  - Bytes scanned reduce without partition count change
  - Result cache is explicitly disabled

- Architects must **measure and validate** SOS usage.
- SOS should be enabled **only when baseline behavior justifies it**.

