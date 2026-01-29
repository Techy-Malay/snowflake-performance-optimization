# Module 1 — Metrics Summary

**Project:** Snowflake Performance Optimization Portfolio  
**Module:** 1 – Partition Pruning with Clustering  
**Author:** Malay Padhi

---

## Baseline Metrics (Before Optimization)

- **Query Type:** Date-range aggregation without clustering
- **Execution Time:** 271 ms
- **Bytes Scanned:** 69.5 MB
- **Partitions Scanned:** 24 / 24
- **Cache State:** Hot cache (100%)

---

## Optimized Metrics (After Optimization)

- **Clustering Key:** `O_ORDERDATE`
- **Execution Time:** Not used (cache-independent comparison)
- **Bytes Scanned:** 18.85 MB
- **Partitions Scanned:** 7 / 23
- **Cache State:** Cold cache (0%)

---

## Improvement Calculations

### Formula
```
((Before - After) / Before) × 100
```

### Results

- **Bytes Reduction (%)**
```
((69.5 - 18.85) / 69.5) × 100 ≈ 72.9%
```

- **Partitions Reduction (%)**
```
((24 - 7) / 24) × 100 ≈ 70.8%
```

- **Success Ratio:** ~71–73%

---

## Validation Notes

- Partition pruning confirmed via query profile
- Optimizer explicitly used clustering key
- Improvement validated under cold cache conditions
- Results indicate structural optimization, not cache dependency

---

## Final Verdict

- **Optimization Type:** Structural (Clustering)
- **Efficiency Gain:** Significant reduction in I/O
- **Scenario Status:** ✅ Successful

