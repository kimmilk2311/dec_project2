WITH dim_product_source AS (
    SELECT *
    FROM `adventureworks2019.Production.Product`   
)

,dim_product_rename AS (
    SELECT 
        ProductID as product_id
        ,Name as product_name
        ,ProductNumber as product_number
        ,MakeFlag as make_flag
        ,FinishedGoodsFlag as finished_goods_flag
        ,ProductSubcategoryID as product_subcategory_id
        ,ProductModelID as product_model_id
        ,SizeUnitMeasureCode as size_unit_measure_id
        ,WeightUnitMeasureCode as weight_unit_measure_id
        ,Color as color
        ,Weight as weight
        ,Size as size
        ,SafetyStockLevel as safety_stock_level
        ,StandardCost as standard_cost
        ,ListPrice as list_price 
    FROM dim_product_source
)

,dim_product_cast_type as (
    SELECT
        CAST(product_id as integer) as product_id
        ,CAST(product_name as string) as product_name
        ,CAST(product_number as string ) as product_number
        ,CAST(make_flag as integer) as make_flag
        ,CAST(finished_goods_flag as integer) as finished_goods_flag
        ,CAST(product_subcategory_id as string) as product_subcategory_id
        ,CAST(product_model_id as string) as product_model_id
        ,CAST(size_unit_measure_id as string) as size_unit_measure_id
        ,CAST(weight_unit_measure_id as string) as weight_unit_measure_id
        ,CAST(color as string) as color
        ,CAST(Weight as string) as weight
        ,CAST(size as string) as size
        ,CAST(safety_stock_level as integer) as safety_stock_level
        ,CAST(standard_cost as float64) as standard_cost
        ,CAST(list_price as float64) as list_price 
    FROM dim_product_rename
)
,dim_product_handle_null as (
  SELECT
    product_id
    ,CASE 
        WHEN product_name = 'NULL' THEN NULL
        ELSE product_name 
    END as product_name
    ,CASE 
        WHEN product_number = 'NULL' THEN NULL
        ELSE product_number
    END as product_number
    ,make_flag
    ,finished_goods_flag
    ,CASE 
        WHEN product_subcategory_id = 'NULL' THEN NULL 
        ELSE product_subcategory_id
    END as product_subcategory_id
    ,CASE 
        WHEN product_model_id = 'NULL' THEN NULL 
        ELSE product_model_id
    END as product_model_id
    ,CASE 
        WHEN size_unit_measure_id = 'NULL' THEN NULL 
        ELSE size_unit_measure_id
    END as size_unit_measure_id
    ,CASE 
        WHEN weight_unit_measure_id = 'NULL' THEN NULL
        ELSE weight_unit_measure_id
    END as weight_unit_measure_id
    ,CASE 
        WHEN color = 'NULL' THEN NULL
        ELSE color
    END as color 
    ,CASE
        WHEN weight = 'NULL' THEN NULL
        ELSE weight
    END as weight
    ,CASE 
        WHEN size = 'NULL' THEN NULL 
        ELSE size
    END as size
    ,safety_stock_level
    ,standard_cost
    ,list_price
  FROM dim_product_rename 
)
,dim_product_underfined_record as (
    SELECT 
        product_id,
        product_name,
        product_number,
        make_flag,
        finished_goods_flag,
        product_subcategory_id,
        product_model_id,
        size_unit_measure_id,
        weight_unit_measure_id,
        color,
        weight,
        size,
        safety_stock_level,
        standard_cost,
        list_price 
    FROM dim_product_handle_null

    UNION ALL 

    SELECT 
       0 as product_id,
       'Undefined' as product_name,
       'Undefined' as product_number,
       0 as make_flag,
       0 as finished_goods_flag,
       '0' as product_subcategory_id,
       '0' as product_model_id,
       'Undefined' as size_unit_measure_id,
       'Undefined' as weight_unit_measure_id,
       'Undefined' as color,
       'Undefined' as weight,
       'Undefined' as size,
       0 as safety_stock_level,
       0.0 as standard_cost,
       0.0 as list_price
)
,dim_product_type AS (
    SELECT
         product_id
        ,product_name
        ,product_number
        ,CASE
            WHEN make_flag = 1 THEN 'in house'
            ELSE 'manufactured in-house'
         END as make_flag
        ,CASE
            WHEN finished_goods_flag = 1 THEN 'salable'
            ELSE 'Not a salable'
        END as finished_goods_flag
        ,product_subcategory_id
        ,product_model_id
        ,size_unit_measure_id
        ,weight_unit_measure_id
        ,color
        ,weight
        ,size
        ,safety_stock_level
        ,standard_cost
        ,list_price 
    FROM dim_product_underfined_record
)
SELECT 
         product_id
        ,product_name
        ,product_number
        ,make_flag
        ,finished_goods_flag
        ,product_subcategory_id
        ,product_model_id
        ,size_unit_measure_id
        ,weight_unit_measure_id
        ,color
        ,weight
        ,size
        ,safety_stock_level
        ,standard_cost
        ,list_price 
FROM dim_product_type