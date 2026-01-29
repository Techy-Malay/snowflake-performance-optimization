/*====================================================
 Project   : Snowflake Performance Optimization Portfolio
 Module    : Module 1 – Partition Pruning with Clustering
 Scenario  : Apply Clustering Key
 Author    : Malay Padhi
------------------------------------------------------
 Description:
   Applies clustering on O_ORDERDATE to enable
   partition pruning for date-range queries.
=====================================================*/

-- Check clustering state (Before)
SELECT SYSTEM$CLUSTERING_INFORMATION(
  'OPTIMIZATION_PROJECT.OPT_SCHEMA.ORDERS'
);

-- Apply clustering key
ALTER TABLE OPTIMIZATION_PROJECT.OPT_SCHEMA.ORDERS
CLUSTER BY (O_ORDERDATE);

-- Verify clustering state (After)
SELECT SYSTEM$CLUSTERING_INFORMATION(
  'OPTIMIZATION_PROJECT.OPT_SCHEMA.ORDERS'
);