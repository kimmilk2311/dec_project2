WITH dim_product_subcategory_source AS (
    SELECT *
    FROM `adventureworks2019.Production.ProductSubcategory`
)

,dim_product_subcategory_rename AS (
    SELECT 
        ProductSubcategoryID AS product_subcategory_id
        ,ProductCategoryID AS product_category_id
        ,Name AS product_subcategory_name
    FROM dim_product_subcategory_source
)

,dim_product_subcategory_cast_type AS (
    SELECT
        CAST(product_subcategory_id as string) as product_subcategory_id
        ,CAST(product_category_id as integer) as product_category_id
        ,CAST(product_subcategory_name as string) as product_subcategory_name
    FROM dim_product_subcategory_rename
)

,dim_product_subcategory_undefined_record AS (
    SELECT 
        product_subcategory_id
        ,product_category_id
        ,product_subcategory_name
    FROM dim_product_subcategory_cast_type

    UNION ALL

    SELECT 
         '0' AS product_subcategory_id
        ,0 AS product_category_id
        ,'Undefined' AS product_subcategory_name
)

SELECT 
        product_subcategory_id
        ,product_category_id
        ,product_subcategory_name
FROM dim_product_subcategory_undefined_record
