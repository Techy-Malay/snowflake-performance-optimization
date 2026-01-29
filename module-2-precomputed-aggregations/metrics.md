# Module 2 — Metrics Summary

**Project:** Snowflake Performance Optimization Portfolio  
**Module:** 2 – Precomputed Aggregations with Materialized Views  
**Author:** Malay Padhi

---

## Baseline Metrics (Before Optimization)

- **Query Type:** Join-heavy, aggregation-heavy daily order metrics
- **Tables Involved:** ORDERS (no MV)
- **Execution Time:** ~2.8 seconds
- **Bytes Scanned:** ~353 MB
- **Partitions Scanned:** ~101
- **Cache State:** Cold cache (0%)
- **Dominant Cost:** Aggregation + Join (engine-heavy)

---

## Optimized Metrics (After Optimization)

- **Optimization Applied:** Materialized View (`ORDERS_DAILY_MV`)
- **Execution Time:** Significantly reduced (aggregation eliminated)
- **Bytes Scanned:** ~31.16 MB
- **Partitions Scanned:** 12 / 23
- **Cache State:** Cold cache (0%)
- **Dominant Cost:** TableScan on Materialized View

---

## Improvement Calculations

### Formula
```
((Before - After) / Before) × 100
```

### Results

- **Bytes Reduction (%)**
```
((353 - 31.16) / 353) × 100 ≈ 91.2%
```

- **Partitions Reduction (%)**
```
((101 - 12) / 101) × 100 ≈ 88.1%
```

- **Success Ratio:** ~88–91%

---

## Validation Evidence

- Aggregate node cost reduced to ~0%
- Query profile confirms Materialized View rewrite
- Join and aggregation work fully eliminated
- Results validated under cold cache conditions

---

## Key Insight

- **Before:** Query was compute-heavy (thinking-heavy)
- **After:** Query converted to simple read (reading-only)

Materialized Views are effective when the same aggregations are repeatedly executed on stable data.

---

## Final Verdict

- **Optimization Type:** Structural (Precomputation)
- **Cost Impact:** Major reduction in compute and I/O
- **Scenario Status:** ✅ Successful

