## Scale-Up — SMALL Warehouse

- Total execution time: ~6m 25s
- Processing (CPU): ~28.4%
- Remote Disk I/O: ~70.9%
- Bytes scanned: ~157 GB (unchanged)
- Dominant operator: TableScan (~74%)

### Observation
Runtime ~halved, but query remains I/O-bound.
Scaling improves overlap, not data access.
