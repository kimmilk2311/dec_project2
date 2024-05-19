WITH dim_product_model_source AS (
    SELECT * 
    FROM `adventureworks2019.Production.ProductModel`
)

,dim_product_model_rename AS (
    SELECT 
        ProductModelID AS product_model_id
        ,Name AS product_model_name 
    FROM dim_product_model_source
)

,dim_product_model_handel_null AS (
    SELECT
        product_model_id
      ,CASE
          WHEN product_model_name = 'NULL' THEN NULL
          ELSE  product_model_name
       END as product_model_name
    FROM dim_product_model_rename
)

,dim_product_model_cast_type AS (
    SELECT 
        CAST(product_model_id AS INTEGER) as product_model_id
        ,CAST(product_model_name AS string) as product_model_name
    FROM dim_product_model_handel_null
)

,dim_product_undefined_record AS (
    SELECT
         product_model_id
        ,product_model_name
    FROM dim_product_model_cast_type

    UNION ALL

    SELECT 
       0 as product_model_id
       ,'Undefined' as product_model_name
)

SELECT
    product_model_id
    ,product_model_name
FROM dim_product_undefined_record