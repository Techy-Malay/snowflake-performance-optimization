/*====================================================
 Project   : Snowflake Performance Optimization Portfolio
 Module    : Module 2 – Precomputed Aggregations
 Scenario  : Baseline Query (Before Materialized View)
 Author    : Malay Padhi
------------------------------------------------------
 Description:
   Baseline aggregation query that recomputes daily
   order metrics on every execution. This query is
   compute-heavy and serves as the comparison point
   for Materialized View optimization.
=====================================================*/

-- Ensure correct context
USE DATABASE OPTIMIZATION_PROJECT;
USE SCHEMA OPT_SCHEMA;

-- Baseline aggregation query (bad by design)
SELECT
    O.O_ORDERDATE               AS order_day,
    COUNT(*)                    AS total_orders,
    SUM(O.O_TOTALPRICE)         AS daily_revenue,
    AVG(O.O_TOTALPRICE)         AS avg_order_value
FROM OPTIMIZATION_PROJECT.OPT_SCHEMA.ORDERS O
WHERE O.O_ORDERDATE >= '1996-01-01'
GROUP BY O.O_ORDERDATE
ORDER BY order_day;