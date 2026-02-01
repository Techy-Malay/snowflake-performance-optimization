-- Baseline query for Module 5.1
-- Warehouse: X-SMALL

SELECT
    d_year,
    i_category,
    COUNT(*)                AS sales_cnt,
    SUM(ss_ext_sales_price) AS total_sales,
    AVG(ss_quantity)        AS avg_qty
FROM SNOWFLAKE_SAMPLE_DATA.TPCDS_SF10TCL.STORE_SALES ss
JOIN SNOWFLAKE_SAMPLE_DATA.TPCDS_SF10TCL.DATE_DIM d
    ON ss.ss_sold_date_sk = d.d_date_sk
JOIN SNOWFLAKE_SAMPLE_DATA.TPCDS_SF10TCL.ITEM i
    ON ss.ss_item_sk = i.i_item_sk
GROUP BY
    d_year,
    i_category;
