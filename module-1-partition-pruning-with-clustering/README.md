# Module 1 – Partition Pruning with Clustering

**Project:** Snowflake Performance Optimization Portfolio\
**Module:** 1\
**Focus:** Clustering Key Optimization\
**Author:** Malay Padhi

---

## 🎯 Problem Statement

Analytical queries filtering on a date column were scanning **all micro-partitions** of the `ORDERS` table due to the absence of a clustering key. Although execution time appeared fast, the query was **structurally inefficient** and dependent on cache.

---

## 🔴 Baseline (Before Optimization)

### Query Pattern

Date-range aggregation on `O_ORDERDATE` without clustering.

### Observed Behavior

- Full partition scan (24 / 24)
- Bytes scanned: \~69.5 MB
- Cache hit: 100% (hot cache)
- Fast execution due to cache, not efficient pruning

### Root Cause

The table lacked a clustering key on the date column used in the filter predicate, preventing effective partition pruning.

---

## 🛠️ Optimization Decision

### Chosen Optimization

Apply a **clustering key on ****O\_ORDERDATE**.

### Why Clustering

- Query pattern is heavily date-driven
- Scan-heavy, I/O-bound workload
- Column pruning already effective
- Clustering enables partition pruning

### Why Not Other Options

- Warehouse scaling would increase cost without fixing scan inefficiency
- Result cache does not solve cold-cache behavior
- SOS is not applicable for range scans

---

## 🟢 After Optimization

### Observed Behavior

- Partitions scanned: **7 / 23**
- Bytes scanned: **18.85 MB**
- Cache hit: **0% (cold cache)**
- Optimizer shows: **"Filter with clustering key"**

### Result

Partition pruning is active and effective. The improvement holds even under cold cache conditions.

---

## 📊 Improvement Metrics

### Formula

```
((Before - After) / Before) × 100
```

### Results

- **Bytes Reduction:** \~72.9%
- **Partitions Reduction:** \~70.8%
- **Success Ratio:** \~71–73%

Execution time is not used as the primary metric due to cache variability.

---

## ❄️ Cold Cache vs Hot Cache

- **Hot Cache:** Can hide inefficient scans
- **Cold Cache:** Reveals true I/O behavior

This optimization was validated under **cold cache**, confirming real structural efficiency rather than cache effects.

---

## ✅ Final Verdict

- Optimization Type: Structural
- Cost Impact: Reduced I/O and predictable scaling
- Scenario Status: **Successful**

---

## 🧠 Key Takeaway

> Fast queries can still be inefficient.\
> Sustainable performance comes from structural decisions, not cache luck.

