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