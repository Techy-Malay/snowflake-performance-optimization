/*====================================================
 Project   : Snowflake Performance Optimization Portfolio
 Module    : Module 2 – Precomputed Aggregations
 Scenario  : Query After Materialized View
 Author    : Malay Padhi
------------------------------------------------------
 Description:
   Re-runs the exact baseline query to validate
   automatic Materialized View rewrite and elimination
   of aggregation cost.
=====================================================*/

-- IMPORTANT: Query must remain logically identical
SELECT
    O.O_ORDERDATE               AS order_day,
    COUNT(*)                    AS total_orders,
    SUM(O.O_TOTALPRICE)         AS daily_revenue,
    AVG(O.O_TOTALPRICE)         AS avg_order_value
FROM OPTIMIZATION_PROJECT.OPT_SCHEMA.ORDERS O
WHERE O.O_ORDERDATE >= '1996-01-01'
GROUP BY O.O_ORDERDATE
ORDER BY order_day;