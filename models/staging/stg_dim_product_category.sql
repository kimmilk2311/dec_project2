WITH dim_product_category_source AS (
    SELECT *
    FROM  `adventureworks2019.Production.ProductCategory`
)

,dim_product_category_rename AS (
    SELECT 
        ProductCategoryID AS product_category_id   
        ,Name AS product_category_name
    FROM dim_product_category_source
)

,dim_product_category_cast_type AS (
    SELECT
        CAST(product_category_id AS INTEGER) AS product_category_id,
        CAST(product_category_name AS string) AS product_category_name,
    FROM dim_product_category_rename 
)

SELECT
    product_category_id
    ,product_category_name
FROM dim_product_category_cast_type