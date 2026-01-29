# Snowflake Performance Optimization

A hands-on, decision-driven portfolio demonstrating **real Snowflake performance optimization scenarios** using evidence, metrics, and architectural reasoning.

> **Philosophy:** Performance tuning is not about tricks. It’s about decisions backed by data.

---

## 🎯 Purpose of This Repository

This repository showcases **end-to-end Snowflake performance optimization** through multiple real-world scenarios. Each module follows a strict **before → optimize → after → verify** approach, supported by:

* Query profiles
* Bytes scanned
* Partitions scanned
* Cache behavior (hot vs cold)

The goal is to demonstrate **architect-level judgment**, not just faster queries.

---

## 🧱 Project Structure

Each module is **self-contained** and includes:

* Clearly defined problem statement
* Baseline (bad query) behavior
* Optimization decision and rationale
* Measured impact with evidence
* Key takeaway

```
snowflake-performance-optimization/
├── module-1-partition-pruning-with-clustering/
├── module-2-precomputed-aggregations-with-materialized-views/
├── module-3-point-lookups-with-search-optimization/
├── module-4-query-profile-driven-optimization/
├── module-5-warehouse-right-sizing-decisions/
├── module-6-storage-optimization-and-compression/
├── module-7-result-and-warehouse-caching-strategy/
└── module-8-zero-copy-cloning-for-safe-testing/
```

---

## 📦 Modules Overview

| Module | Focus Area        | Key Decision                        |
| ------ | ----------------- | ----------------------------------- |
| 1      | Partition pruning | When clustering is the right choice |
| 2      | Aggregations      | Materialized views vs compute       |
| 3      | Point lookups     | Search Optimization Service (SOS)   |
| 4      | Query analysis    | Fixing SQL using query profiles     |
| 5      | Compute           | Warehouse sizing trade-offs         |
| 6      | Storage           | Modeling and scan-cost decisions    |
| 7      | Caching           | Result vs warehouse cache           |
| 8      | Testing           | Zero-copy cloning strategies        |

---

## 🔍 Dataset & Environment

* **Platform:** Snowflake
* **Sample Data:** `SNOWFLAKE_SAMPLE_DATA.TPCH_SF10`
* **Warehouse Size:** XS (unless stated otherwise)
* **Primary Metrics:**

  * Bytes scanned
  * Partitions scanned

Execution time is treated as **secondary** due to cache variability.

---

## 📊 Measurement Framework

All improvements are calculated using:

```
((Before - After) / Before) × 100
```

Primary success indicators:

* Reduction in **bytes scanned**
* Reduction in **partitions scanned**

---

## 🧠 Key Principles

* Evidence over assumptions
* Cold-cache validation over lucky cache hits
* One optimization at a time
* Interview-defensible reasoning

---

## 📌 Project Status

* Module 1: Completed
* Remaining modules: Planned and in progress

---

## 👤 Author

**Malay Padhi**
  | Senior Solution Architect | Data Architecture | Snowflake Performance

---

> **Takeaway:** Fast queries can still be inefficient. Sustainable performance comes from structural decisions.
