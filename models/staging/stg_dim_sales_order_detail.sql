WITH dim_sales_oder_detail_source as (
    SELECT *
    FROM `adventureworks2019.Sales.SalesOrderDetail`
)

,dim_sales_oder_detail_rename as (
    SELECT
        SalesOrderID as sales_order_id
        ,SalesOrderDetailID as sales_order_line_id
        ,ProductID as product_id
        ,OrderQty as order_quantity
        ,UnitPrice as unit_price
        ,UnitPriceDiscount as unit_price_discount
    FROM dim_sales_oder_detail_source
)

,dim_sales_oder_detail_cast_type as (
    SELECT
        cast(sales_order_id as integer) as sales_order_id
        ,cast(sales_order_line_id as integer) as sales_order_line_id
        ,cast(product_id as integer) as product_id
        ,cast(order_quantity as integer) as order_quantity
        ,cast(unit_price as float64) as unit_price
        ,cast(unit_price_discount as float64) as unit_price_discount
    FROM dim_sales_oder_detail_rename
) 

,dim_sales_oder_detail_underfined_record as (
    SELECT
        sales_order_id
        ,sales_order_line_id
        ,product_id
        ,order_quantity
        ,unit_price
        ,unit_price_discount
    FROM dim_sales_oder_detail_cast_type

    UNION ALL
    
    SELECT
        0 as sales_order_id
        ,0 as sales_order_line_id
        ,0 as product_id
        ,0 as order_quantity
        ,0.0 as unit_price
        ,0.0 as unit_price_discount
)

,dim_sales_oder_detail_with_gross_amount as (
    SELECT 
        sales_order_id
        ,sales_order_line_id
        ,product_id
        ,order_quantity
        ,unit_price
        ,unit_price_discount
        ,unit_price * (1 - unit_price_discount) * order_quantity as gross_amount
    FROM dim_sales_oder_detail_underfined_record
)

,dim_sales_oder_detail_calculate_metrics_total_due as (
    SELECT
        sales_order_id
        ,sales_order_line_id
        ,product_id
        ,order_quantity
        ,unit_price
        ,unit_price_discount
        ,gross_amount
        ,SUM(gross_amount) as total_due
    FROM dim_sales_oder_detail_with_gross_amount
    GROUP BY sales_order_id
            ,sales_order_line_id
            ,product_id
            ,order_quantity
            ,unit_price
            ,unit_price_discount
            ,gross_amount
)

SELECT
        sales_order_id
        ,sales_order_line_id
        ,product_id
        ,order_quantity
        ,unit_price
        ,unit_price_discount
        ,gross_amount
        ,total_due
FROM dim_sales_oder_detail_calculate_metrics_total_due