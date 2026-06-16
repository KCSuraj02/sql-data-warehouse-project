/*
==============================================================================
  Quality Checks
==============================================================================
  Script Purpose:
  This script performs various quality checks for data consistency, accuracy,
  and standardization across the 'silver' schema. It includes checks for:
    - Null or duplicates primary keys.
    - Unwanted spaces in string fields.
    - Data standardization and consistency.
    - Invalid data ranges and orders.
    - Data consistency between related fields.

  Usage Notes:
    - Run these checks after data loading Silver Layer.
    - Investigate and resolve any discrepencies found during the checks.
*/
--===========================================================================
-- Checking silver.crm_cust_info
--===========================================================================
-- Check for Nulls or Duplicates in Primary Key
-- Expectation: No Result
SELECT cst_id, COUNT(*) AS 'Repeats'
FROM silver.crm_cust_info
GROUP BY cst_id
HAVING COUNT(*) > 1 OR cst_id IS NULL

-- Check for Unwanted Spaces
-- Expectation: No Result
SELECT cst_key
FROM silver.crm_cust_info
WHERE cst_key != TRIM(cst_key)

--Data Standardization and Consistency
SELECT DISTINCT cst_gndr
FROM silver.crm_cust_info

SELECT DISTINCT cst_marital_status
FROM silver.crm_cust_info

--===========================================================================
-- Checking silver.crm_prd_info
--===========================================================================
  
--Check for NULLs or Negative Numbers
--Expectation: No Results
SELECT prd_cost
FROM silver.crm_prd_info
WHERE prd_cost < 0 OR prd_cost IS NULL

--Check for Invalid Date Orders
SELECT *
FROM silver.crm_prd_info
WHERE prd_end_dt < prd_start_dt
