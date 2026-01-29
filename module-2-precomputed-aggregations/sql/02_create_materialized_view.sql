/*====================================================
 Project   : Snowflake Performance Optimization Portfolio
 Module    : Module 2 – Precomputed Aggregations
 Scenario  : Create Materialized View
 Author    : Malay Padhi
------------------------------------------------------
 Description:
   Creates a single-table Materialized View on the
   ORDERS table to precompute daily order metrics.
   This eliminates repeated aggregation cost for
   read-heavy analytical workloads.
=====================================================*/

-- Ensure correct context
USE DATABASE OPTIMIZATION_PROJECT;
USE SCHEMA OPT_SCHEMA;

-- Create Materialized View
CREATE OR REPLACE MATERIALIZED VIEW ORDERS_DAILY_MV
COMMENT = 'Precomputed daily order metrics for aggregation optimization'
AS
SELECT
    O.O_ORDERDATE               AS order_day,
    COUNT(*)                    AS total_orders,
    SUM(O.O_TOTALPRICE)         AS daily_revenue,
    AVG(O.O_TOTALPRICE)         AS avg_order_value
FROM OPTIMIZATION_PROJECT.OPT_SCHEMA.ORDERS O
WHERE O.O_ORDERDATE >= '1996-01-01'
GROUP BY O.O_ORDERDATE;

-- Verify MV existence
SHOW MATERIALIZED VIEWS LIKE 'ORDERS_DAILY_MV';