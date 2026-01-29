# Metrics — Result Cache Validation

| Run | Bytes Scanned | TableScan Present | Result Cache Used |
|-----|---------------|-------------------|-------------------|
| Cold run | > 0 | Yes | No |
| Exact re-run | 0 | No | Yes |
| Semantic change | > 0 | Yes | No |
