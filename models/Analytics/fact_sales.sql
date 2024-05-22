SELECT
     fact_sales.sales_order_line_id
    ,fact_sales.sales_order_id
    ,fact_sales.product_id
    ,fact_sales_oder_header.customer_id
    ,fact_sales_oder_header.sales_territory_id
    ,fact_sales_oder_header.sales_person_id
    ,fact_sales_oder_header.order_date
    ,fact_sales_oder_header.status as sales_order_status
    ,fact_sales_oder_header.bill_to_address_id
    ,fact_sales_oder_header.ship_to_adrress_id
    ,fact_sales.order_quantity
    ,fact_sales.unit_price
    ,fact_sales.unit_price_discount
    ,fact_sales_oder_header.tax_amount
    ,fact_sales_oder_header.total_due
FROM
    {{ref("stg_dim_sales_order_detail")}} as fact_sales
    LEFT JOIN {{ref("stg_dim_sales_oder_header")}} as fact_sales_oder_header
        ON fact_sales.sales_order_id = fact_sales_oder_header.sales_order_id