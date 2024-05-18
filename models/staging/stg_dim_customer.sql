WITH dim_customer_source as (
SELECT * 
FROM `adventureworks2019.Sales.Customer`
)

,dim_customer_rename as (
SELECT 
    CustomerID as customer_id
    ,PersonID as person_id
    ,StoreID as store_id
FROM dim_customer_source
)

,dim_customer_handel_null as (
SELECT 
    customer_id,
    CASE
       WHEN person_id = 'NULL' THEN NULL
       ELSE person_id
    END as person_id,
    CASE
       WHEN store_id = 'NULL' THEN NULL 
       ELSE store_id
    END as store_id
FROM dim_customer_rename
)

,dim_customer_cast_type as (
SELECT 
    cast(customer_id as integer) as customer_id
    ,cast(person_id as integer) as person_id
    ,cast(store_id as integer) as store_id
FROM dim_customer_handel_null
)

,dim_customer_underfined_record as (
SELECT 
   customer_id
   ,person_id 
   ,store_id
FROM dim_customer_cast_type

UNION ALL

SELECT
   0 as customer_id
   ,0 as person_id
   ,0 as store_id
)

SELECT
   customer_id
   ,person_id 
   ,store_id
FROM dim_customer_underfined_record
