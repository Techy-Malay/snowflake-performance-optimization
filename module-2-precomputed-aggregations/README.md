# Module 2 – Precomputed Aggregations with Materialized Views

**Project:** Snowflake Performance Optimization Portfolio  \
**Module:** 2  \
**Focus:** Reducing Compute Cost using Materialized Views  \
**Author:** Malay Padhi

---

## 🎯 Problem Statement

Analytical queries were repeatedly executing **join-heavy and aggregation-heavy logic** on the `ORDERS` table to calculate daily order metrics. Although the data volume was moderate, the **same aggregates were recomputed on every execution**, resulting in unnecessary compute cost and poor scalability.

---

## 🔴 Baseline (Before Optimization)

### Query Pattern

- Daily aggregation on `O_ORDERDATE`
- Multiple aggregates: `COUNT`, `SUM`, `AVG`
- Executed frequently with identical logic

### Observed Behavior

- High aggregation and compute cost
- Join and aggregate operators dominate the query profile
- Bytes scanned: ~353 MB
- Partitions scanned: ~101
- Cache state: Cold cache (0%)

### Root Cause

The query was **compute-heavy (thinking-heavy)**. The engine repeatedly performed the same aggregations instead of reusing precomputed results.

---

## 🛠️ Optimization Decision

### Chosen Optimization

**Materialized View (MV)** on the `ORDERS` table.

### Why Materialized View

- Aggregation logic is stable and repeatable
- Read-heavy analytical workload
- Acceptable freshness lag
- Eliminates repeated aggregation work

### Design Constraint (Important)

Snowflake Materialized Views support **single-table definitions only**. Multi-table joins are not allowed, so the optimization was scoped to `ORDERS`.

---

## 🟢 After Optimization

### Implementation

A Materialized View (`ORDERS_DAILY_MV`) was created to precompute daily order metrics.

### Observed Behavior

- Aggregation cost reduced to ~0%
- Query rewritten automatically to use the MV
- Bytes scanned reduced to ~31 MB
- Partitions scanned reduced to 12 / 23
- Cache state: Cold cache (0%)

### Query Profile Confirmation

- Aggregate node effectively eliminated
- TableScan operates on the Materialized View

---

## 📊 Improvement Metrics

### Formula

```
((Before - After) / Before) × 100
```

### Results

- **Bytes Reduction:** ~91.2%
- **Partitions Reduction:** ~88.1%
- **Success Ratio:** ~88–91%

Execution time is not the primary metric due to cache variability.

---

## ❄️ Cold Cache Validation

All comparisons were performed under **cold cache conditions**, ensuring the observed improvements are structural and not cache-dependent.

---

## ✅ Final Verdict

- Optimization Type: Structural (Precomputation)
- Problem Addressed: Repeated compute cost
- Result: Query converted from compute-heavy to read-only
- Scenario Status: **Successful**

---

## 🧠 Key Takeaway

> When queries spend time **thinking** instead of **reading**, precompute the thinking.

Materialized Views are effective when aggregation logic is stable and repeatedly executed.

