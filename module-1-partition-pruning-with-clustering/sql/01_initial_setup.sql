/*====================================================
 Project   : Snowflake Performance Optimization Portfolio
 Module    : Module 1 – Partition Pruning with Clustering
 Author    : Malay Padhi
------------------------------------------------------
 Description:
   Initial setup for the optimization project.
   Creates database, schema, and base tables using
   TPCH_SF10 sample data.
=====================================================*/

-- Create database
CREATE DATABASE IF NOT EXISTS OPTIMIZATION_PROJECT;

-- Use database
USE DATABASE OPTIMIZATION_PROJECT;

-- Create schema
CREATE SCHEMA IF NOT EXISTS OPT_SCHEMA;

-- Use schema
USE SCHEMA OPT_SCHEMA;

-- Create ORDERS table
CREATE OR REPLACE TABLE ORDERS AS
SELECT *
FROM SNOWFLAKE_SAMPLE_DATA.TPCH_SF10.ORDERS;

-- Create LINEITEM table
CREATE OR REPLACE TABLE LINEITEM AS
SELECT *
FROM SNOWFLAKE_SAMPLE_DATA.TPCH_SF10.LINEITEM;

-- Verify row counts
SELECT 'ORDERS' AS table_name, COUNT(*) AS row_count FROM ORDERS
UNION ALL
SELECT 'LINEITEM', COUNT(*) FROM LINEITEM;