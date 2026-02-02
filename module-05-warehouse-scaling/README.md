# Module 5 — Warehouse & Scaling Strategies

## Project
**Snowflake Performance Optimization Portfolio**  
**Module:** 5 (Warehouse & Scaling)

---

## Objective
Understand **when and why** Snowflake warehouse scaling features work:
- Warehouse sizing
- Single-cluster vs multi-cluster behavior
- Time-slicing vs overload queueing
- Why **multi-cluster** is *not* a performance booster, but a **concurrency safety valve**
- Why **QAS is not relevant** for concurrency problems

This module focuses on **scheduler behavior**, not query tuning.

---

## Test Environment
- **Warehouse:** `COMPUTE_WH`
- **Warehouse Size:** X-SMALL / SMALL (as specified per test)
- **Edition:** Enterprise (QAS available)
- **Cluster Settings:**
  - Single cluster: `MIN_CLUSTER=1, MAX_CLUSTER=1`
  - Multi-cluster: `MIN_CLUSTER=1, MAX_CLUSTER=3`
- **Dataset:** `SNOWFLAKE_SAMPLE_DATA.TPCDS_SF10TCL`
- **Query Type:** CPU + aggregation heavy analytical join

---

## Core Mental Model (Applied)

| Concept | Meaning |
|------|-------|
| **Distance** | Data scanned / I/O / partitions |
| **Thinking** | CPU work (joins, aggregations, grouping) |

**Warehouse scaling and multi-cluster address neither Distance nor Thinking.**  
They address **scheduler pressure**.

---

## Experiments & Findings

### 1️⃣ Single Cluster — Moderate Concurrency
- 3–6 concurrent heavy queries
- Result:
  - All queries ran concurrently
  - No queueing
  - Queries slowed due to **CPU time-slicing**

**Key insight:**
> Slow queries ≠ queued queries

---

### 2️⃣ Single Cluster — High Concurrency (Forced Overload)
- **12 concurrent queries**
- Warehouse: **X-SMALL, single cluster**

**Observed:**
- Queries entered **Queued** state
- `QUEUED_OVERLOAD_TIME` reached **hundreds of seconds**
- Execution time for some queries was minimal after waiting

**Proof Source:**
- `SNOWFLAKE.ACCOUNT_USAGE.QUERY_HISTORY`

**Conclusion:**
> Single cluster execution slots were exhausted → real overload queueing occurred

---

### 3️⃣ Multi-Cluster Enabled (MAX_CLUSTER=3)
- Same 12-query burst
- No query rewrite
- No warehouse resize

**Observed:**
- All queries immediately **Running**
- Queueing almost eliminated
- `QUEUED_OVERLOAD_TIME` dropped from **~500,000 ms → ~189 ms**

**Interpretation:**
- Residual milliseconds = cluster spin-up latency
- Scheduler pressure absorbed by additional clusters

---

## Key Learnings (Locked)

- **Snowflake prefers time-slicing over queueing**
- Queueing is the **last resort**, not the first
- **Multi-cluster solves overload queueing only**
- Multi-cluster does **NOT**:
  - Make queries faster
  - Reduce scan
  - Reduce CPU per query
- **QAS is unrelated** to concurrency and queueing problems
- ACCOUNT_USAGE views are **delayed** and are not real-time telemetry

---

## When to Use Multi-Cluster (Decision Rule)

Use multi-cluster **ONLY IF**:
- Queries show `QUEUED_OVERLOAD_TIME > 0`
- Many concurrent users or dashboards
- Burst concurrency patterns

Do **NOT** use multi-cluster when:
- Queries are slow due to scan or joins
- CPU is saturated but queries are still running
- The problem is query design or data model

---

## Evidence Sources Used
- Query History (Queued vs Running)
- `SNOWFLAKE.ACCOUNT_USAGE.QUERY_HISTORY`
- Warehouse configuration changes

(Cluster count inferred via scheduler behavior; `WAREHOUSE_LOAD_HISTORY` confirmed later due to system lag.)

---

## Final Conclusion

> **Multi-cluster is a fairness and throughput mechanism — not a performance optimization tool.**

This module demonstrates **why forcing Snowflake features in labs is difficult**, and why understanding **scheduler intent** matters more than chasing demos.

---

## Next Module
➡️ **Module 6 — Query Design & Rewrite Patterns**  
(Focus: reducing Distance and Thinking instead of scaling compute)

