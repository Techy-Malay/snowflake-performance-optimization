-- ============================================================================
-- Scenario 3: Search Optimization Service (SOS)
-- queries.sql
--
-- Purpose:
-- --------
-- This file contains all queries used to validate Search Optimization Service.
-- Queries are executed in a controlled manner to demonstrate when SOS is
-- chosen by the optimizer and when it is not.
--
-- IMPORTANT RULES:
-- ----------------
-- - Do not modify queries between runs
-- - Use the same warehouse and role
-- - Disable result cache when measuring SOS impact
-- ============================================================================

-- ---------------------------------------------------------------------------
-- Case 1: ORDERS table (SOS not chosen by optimizer) - FAILED
-- ---------------------------------------------------------------------------

-- Baseline point lookup on non-clustered column
SELECT 
    O_ORDERKEY,
    O_ORDERDATE,
    O_TOTALPRICE,
    O_ORDERSTATUS,
    O_CLERK,
    O_COMMENT
FROM ORDERS
WHERE O_ORDERKEY = 100001;


-- ---------------------------------------------------------------------------
-- Case 2: LINEITEM table (SOS chosen by optimizer)
-- ---------------------------------------------------------------------------

-- Baseline point lookup on a very large table
SELECT
    L_ORDERKEY,
    L_PARTKEY,
    L_SUPPKEY,
    L_LINENUMBER,
    L_QUANTITY,
    L_EXTENDEDPRICE,
    L_SHIPDATE
FROM LINEITEM
WHERE L_ORDERKEY = 100001;


-- ---------------------------------------------------------------------------
-- Session control for accurate measurement
-- ---------------------------------------------------------------------------





/*## LINEITEM — Baseline (Before SOS)

- Execution time:1.0 sec
- Bytes scanned:
- Partitions scanned:
- TableScan present:

*/

-- SOS command
ALTER TABLE LINEITEM
ADD SEARCH OPTIMIZATION ON EQUALITY(L_ORDERKEY);

-- verify SOS is present

DESCRIBE SEARCH OPTIMIZATION ON LINEITEM;


-- Disable result cache to ensure SOS impact is measured

ALTER SESSION SET USE_CACHED_RESULT = FALSE;


--Re-run the same LINEITEM query (unchanged):

SELECT
    L_ORDERKEY,
    L_PARTKEY,
    L_SUPPKEY,
    L_LINENUMBER,
    L_QUANTITY,
    L_EXTENDEDPRICE,
    L_SHIPDATE
FROM LINEITEM
WHERE L_ORDERKEY = 100001;

/*## measured Parameter

- Execution time:1.0 sec
- Bytes scanned:
- Partitions scanned:
- TableScan present:

*/