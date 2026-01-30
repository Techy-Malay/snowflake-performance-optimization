# Metrics — Search Optimization Service (SOS)

This document records **observed facts only**.
No interpretation or conclusions are included here.

---

## ORDERS — Baseline and After SOS

### Baseline (Before SOS)

- Execution time: ~1.1 s
- Bytes scanned: ~56.09 MB
- Partitions scanned: 19 / 23
- TableScan present: Yes
- Search Optimization used: No

### After SOS (ACTIVE)

- Execution time: ~2.2 s
- Bytes scanned: ~56.09 MB
- Partitions scanned: 19 / 23
- TableScan present: Yes
- Search Optimization used: No

---

## LINEITEM — Baseline and After SOS

### Baseline (Before SOS)

- Execution time: ~838 ms
- Bytes scanned: ~2.94 MB
- Partitions scanned: 1 / 89
- TableScan present: Yes
- Search Optimization used: No

### After SOS (ACTIVE)

- Execution time: ~58 ms
- Bytes scanned: ~2.09 MB
- Partitions scanned: 1 / 89
- TableScan present: No
- Search Optimization used: Yes

---

## Measurement Controls

- Same warehouse used across runs
- Same role used across runs
- Result cache disabled during SOS measurements
- Queries kept identical between baseline and post-SOS runs

