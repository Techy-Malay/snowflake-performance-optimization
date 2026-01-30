# Scenario 3 — Search Optimization Service (SOS)

## Objective
Demonstrate **when and why Search Optimization Service (SOS) is used by Snowflake**, and when it is deliberately **not chosen** by the optimizer.

The goal is not to show SOS as a guaranteed speedup, but to prove that it is a **cost-based, distance-reduction optimization**.

---

## Mental Model Alignment

- **Distance** = bytes scanned / data accessed
- **Thinking** = CPU work (joins, aggregations)

SOS operates **only on distance**.
It does **not** reduce thinking.

---

## Baseline Problem

Point lookups on non-clustered columns can still cause:
- Micro-partition scans
- High I/O cost
- Unnecessary data traversal

This is especially visible on **large tables**.

---

## Experiments Conducted

### Case 1 — ORDERS Table

- Query: point lookup on `O_ORDERKEY`
- Table size: relatively small

**Result:**
- SOS enabled but **not used**
- Optimizer preferred table scan

This proves:
- SOS is **not automatically applied**
- Optimizer chooses the cheapest plan

---

### Case 2 — LINEITEM Table

- Query: point lookup on `L_ORDERKEY`
- Table size: significantly larger

**Result:**
- SOS enabled and **used**
- Table scan work eliminated
- Execution time reduced significantly

This proves:
- SOS is effective when partition pruning is insufficient
- SOS shines on **large tables with selective predicates**

---

## How SOS Usage Is Confirmed

Snowflake does **not** display an explicit SOS operator.

SOS usage is inferred by:
- Collapse of TableScan cost to ~0
- Reduction in bytes scanned
- Unchanged partition count
- Result cache explicitly disabled

---

## Key Takeaways

- SOS reduces **data access distance**, not computation
- SOS is **cost-based**, not guaranteed
- SOS must be **validated**, not assumed
- Architects should enable SOS only after measuring baseline behavior

---

## Scope Boundaries

This scenario does NOT cover:
- Query rewrites
- Join optimization
- Aggregation optimization
- Warehouse sizing

Those belong to later scenarios.

---

## Conclusion

Search Optimization Service is a **precision tool**.

Used correctly, it eliminates unnecessary data traversal.
Used blindly, it adds cost with no benefit.

Architects must measure first, then decide.

