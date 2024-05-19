WITH dim_customer_source AS (
    SELECT *
    FROM `adventureworks2019.Sales.Customer`
)
,dim_customer_rename AS (
    SELECT 
        CustomerID AS customer_id,
        PersonID AS person_id,
        StoreID AS store_id
    FROM dim_customer_source
)
,dim_customer_handle_null AS (
    SELECT 
        customer_id,
        CASE
           WHEN person_id = 'NULL' THEN NULL
           ELSE person_id
        END AS person_id,
        CASE
           WHEN store_id = 'NULL' THEN NULL 
           ELSE store_id
        END AS store_id
    FROM dim_customer_rename
)
,dim_customer_cast_type AS (
    SELECT 
        CAST(customer_id AS INTEGER) AS customer_id,
        CAST(person_id AS INTEGER) AS person_id,
        CAST(store_id AS INTEGER) AS store_id
    FROM dim_customer_handle_null
)
,dim_customer_undefined_record AS (
    SELECT 
       customer_id,
       person_id,
       store_id,
    FROM dim_customer_cast_type

    UNION ALL
    
    SELECT
       0 AS customer_id,
       0 AS person_id,
       0 AS store_id,
)
,dim_customer_type AS (
    SELECT
       customer_id,
       person_id,
       store_id,
       CASE
           WHEN store_id IS NOT NULL THEN 'reseller'
           ELSE 'customer'
       END AS is_reseller
    FROM dim_customer_undefined_record
)
SELECT
   customer_id,
   person_id,
   store_id,
   is_reseller
FROM dim_customer_type