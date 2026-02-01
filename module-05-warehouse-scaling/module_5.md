## Do we need to create tables?

**No.**

`SNOWFLAKE_SAMPLE_DATA.TPCDS_SF10TCL` is **pre-created, managed, and shared by Snowflake**.
You must **not** create, load, or modify these tables.

This is intentional:
- Ensures reproducibility
- Removes data-loading noise
- Keeps focus on **warehouse scaling behavior**

---

## Required Setup (One-Time)

```sql
-- Use your working warehouse
USE WAREHOUSE XSMALL_WH;

-- Ensure size is X-SMALL for baseline
ALTER WAREHOUSE XSMALL_WH SET WAREHOUSE_SIZE = 'X-SMALL';
```

---

## Baseline Query — DO NOT MODIFY

This is the **control query** for Module 5.1.

```sql
SELECT
    d_year,
    i_category,
    COUNT(*)                 AS sales_cnt,
    SUM(ss_ext_sales_price)  AS total_sales,
    AVG(ss_quantity)         AS avg_qty
FROM SNOWFLAKE_SAMPLE_DATA.TPCDS_SF10TCL.STORE_SALES ss
JOIN SNOWFLAKE_SAMPLE_DATA.TPCDS_SF10TCL.DATE_DIM d
    ON ss.ss_sold_date_sk = d.d_date_sk
JOIN SNOWFLAKE_SAMPLE_DATA.TPCDS_SF10TCL.ITEM i
    ON ss.ss_item_sk = i.i_item_sk
GROUP BY
    d_year,
    i_category;
```

---

## What to Capture (Facts Only)

After execution, open **Query Profile** and record:

- Execution time
- Processing %
- Remote Disk I/O %
- Bytes scanned
- CPU saturation (Yes / No)

⚠️ Do **not** analyze yet.

---

## Stop Condition

If execution time is **< 10 seconds**, stop and report.
We will increase CPU pressure deliberately.

---

## Next Step (After You Report Results)

We will scale the **same warehouse** to **SMALL** and rerun the **same query**.

No other changes allowed.



---

## README.md (Module Root)

```md
# Module 5.1 — Warehouse Size vs Query Performance

## Objective
Understand how Snowflake warehouse scaling affects query performance, and why scaling helps CPU-bound workloads more than I/O-bound ones.

## Dataset
- SNOWFLAKE_SAMPLE_DATA.TPCDS_SF10TCL
- Large analytical fact tables (STORE_SALES)

## Experiment Design
- Same query
- Same data
- Same warehouse
- Only warehouse size changed (X-SMALL → SMALL)

## Key Results
- X-SMALL: ~11m 54s (I/O dominated)
- SMALL:  ~6m 25s (sub-linear improvement)

## Core Insight
Warehouse scaling improves performance by increasing compute parallelism and I/O overlap, but does not reduce data scanned. I/O-bound queries remain I/O-bound after scaling.

## Architectural Takeaway
Scaling is a tactical decision to buy time, not a root-cause optimization. True optimization requires query design, filtering, or data modeling changes.

## Related Files
- 01-baseline-xsmall/
- 02-scale-small/
- conclusions/
```

