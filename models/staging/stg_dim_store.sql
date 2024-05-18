WITH dim_store_source as (
  SELECT *
  FROM  `adventureworks2019.Sales.Store`
)

,dim_store_rename as (
SELECT 
    BusinessEntityID as store_id
    ,Name as store_name
    ,SalesPersonID as sales_person_id
FROM dim_store_source
)

,dim_store_cast_type as (
 SELECT 
    cast(store_id as integer ) as store_id
   ,cast(store_name as string) as store_name
   ,cast( sales_person_id as integer ) as sales_person_id 
 FROM dim_store_rename
)

,dim_store_add_underfined_record as (
SELECT 
    store_id
    ,store_name
    ,sales_person_id
FROM dim_store_cast_type

UNION ALL 

SELECT
    0 as store_id
    ,'Undefined' as store_name
    ,0 as sales_person_id
)

SELECT
    store_id
    ,store_name
    ,sales_person_id
FROM dim_store_add_underfined_record