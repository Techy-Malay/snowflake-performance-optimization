/*====================================================
 Project   : Snowflake Performance Optimization Portfolio
 Module    : Module 1 – Partition Pruning with Clustering
 Scenario  : Validation Query After Clustering
 Author    : Malay Padhi
------------------------------------------------------
 Description:
   Re-runs the exact baseline query after clustering
   to validate partition pruning and reduced I/O.
=====================================================*/

-- IMPORTANT: Query must be identical to baseline
SELECT
    O_ORDERDATE,
    COUNT(*) AS order_count,
    SUM(O_TOTALPRICE) AS total_revenue
FROM OPTIMIZATION_PROJECT.OPT_SCHEMA.ORDERS
WHERE O_ORDERDATE BETWEEN '1996-01-01' AND '1996-12-31'
GROUP BY O_ORDERDATE
ORDER BY O_ORDERDATE;