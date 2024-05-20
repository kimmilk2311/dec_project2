SELECT
    dim_product.product_id
    ,dim_product.product_name
    ,dim_product.product_number
    ,dim_product.make_flag
    ,dim_product.finished_goods_flag
    ,dim_product.product_subcategory_id
    ,dim_product_subcategory.product_subcategory_name
    ,dim_product_subcategory.product_category_id
    ,dim_product_category.product_category_name
    ,dim_product.size_unit_measure_id
    ,dim_product_unit_size_measure.unit_measure_name as size_unit_measure_name
    ,dim_product.weight_unit_measure_id
    ,dim_product_unit_size_measure.unit_measure_name as weight_unit_measure_name
    ,dim_product.color
    ,dim_product.size
    ,dim_product.safety_stock_level
    ,dim_product.standard_cost
    ,dim_product.list_price 
FROM
    {{ref("stg_dim_product")}} as dim_product
    LEFT JOIN {{ref("stg_dim_product_subcategory")}} as dim_product_subcategory
        ON dim_product.product_subcategory_id = dim_product_subcategory.product_subcategory_id
    LEFT JOIN {{ref("stg_dim_product_category")}} as dim_product_category
        ON dim_product_subcategory.product_category_id = dim_product_category.product_category_id
    LEFT JOIN {{ref("stg_dim_product_unit_measure")}} as dim_product_unit_size_measure
        ON dim_product.size_unit_measure_id = dim_product_unit_size_measure.unit_measure_id
    LEFT JOIN {{ref("stg_dim_product_unit_measure")}} as dim_product_unit_weight_measure
        ON dim_product.weight_unit_measure_id = dim_product_unit_weight_measure.unit_measure_id