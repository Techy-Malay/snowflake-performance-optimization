

# Module 5.1 — Warehouse Scaling Conclusions

## Key Findings

1. Warehouse scaling improves performance but **sub-linearly** for I/O-bound queries
2. Scaling does NOT reduce:
   - Bytes scanned
   - Partitions scanned
3. Scaling shifts time from I/O → CPU but cannot fix Distance
4. Blind scale-up is capacity buying, not optimization

## Architectural Decision Rule

- CPU-bound → consider scaling
- I/O-bound → fix query, model, or data layout first
- Scaling is a tactical choice, not a root-cause fix
