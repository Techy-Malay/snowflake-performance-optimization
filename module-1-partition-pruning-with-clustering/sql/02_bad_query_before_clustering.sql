/*====================================================
 Project   : Snowflake Performance Optimization Portfolio
 Module    : Module 1 – Partition Pruning with Clustering
 Scenario  : Baseline Bad Query (No Clustering)
 Author    : Malay Padhi
------------------------------------------------------
 Description:
   Baseline analytical query demonstrating full
   partition scan due to missing clustering on
   O_ORDERDATE.
=====================================================*/

-- Ensure correct context
USE DATABASE OPTIMIZATION_PROJECT;
USE SCHEMA OPT_SCHEMA;

-- Baseline bad query
SELECT
    O_ORDERDATE,
    COUNT(*) AS order_count,
    SUM(O_TOTALPRICE) AS total_revenue
FROM ORDERS
WHERE O_ORDERDATE BETWEEN '1996-01-01' AND '1996-12-31'
GROUP BY O_ORDERDATE
ORDER BY O_ORDERDATE;