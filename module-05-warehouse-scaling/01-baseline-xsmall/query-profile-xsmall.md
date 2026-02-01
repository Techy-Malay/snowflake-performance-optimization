## Baseline — X-SMALL Warehouse

- Total execution time: ~11m 54s
- Processing (CPU): ~21.9%
- Remote Disk I/O: ~77.6%
- Bytes scanned: ~157 GB
- Partitions scanned: ~97%
- Dominant operator: TableScan (~80%)

### Interpretation
Query is **I/O-bound (Distance-heavy)**.
Warehouse scaling cannot eliminate the bottleneck.
