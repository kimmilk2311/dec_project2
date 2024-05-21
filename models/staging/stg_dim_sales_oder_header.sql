WITH dim_sales_oder_header_source as (
    SELECT *
    FROM `adventureworks2019.Sales.SalesOrderHeader`
)

,dim_sales_oder_header_rename as (
    SELECT
        SalesOrderID as sales_order_id
        ,OrderDate as order_date
        ,CustomerID as customer_id
        ,TerritoryID as sales_territory_id
        ,SalesPersonID as sales_person_id
        ,Status as status
        ,BillToAddressID as bill_to_address_id
        ,ShipToAddressID as ship_to_adrress_id
        ,SubTotal
        ,TaxAmt as tax_amount
        ,Freight
    FROM dim_sales_oder_header_source
)
,dim_sales_oder_header_handel_null as (
    SELECT
        sales_order_id
        ,order_date
        ,customer_id
        ,sales_territory_id
        ,CASE
            WHEN sales_person_id = 'NULL' THEN NULL
            ELSE sales_person_id
        END as sales_person_id
        ,status
        ,bill_to_address_id
        ,ship_to_adrress_id
        ,SubTotal
        ,tax_amount
        ,Freight
    FROM dim_sales_oder_header_rename 

)
,dim_sales_oder_header_cast_type as (
    SELECT
        cast(sales_order_id as integer) as sales_order_id
        ,cast( order_date as TIMESTAMP) as  order_date
        ,cast(customer_id as integer) as customer_id
        ,cast(sales_territory_id as integer) as sales_territory_id
        ,cast(sales_person_id as integer) as sales_person_id
        ,cast(status as string) as status
        ,cast(bill_to_address_id as integer) as bill_to_address_id
        ,cast(ship_to_adrress_id as integer) as ship_to_adrress_id
        ,cast(SubTotal as float64) as SubTotal
        ,cast(tax_amount as float64) as tax_amount
        ,cast(Freight as float64) as Freight
    FROM dim_sales_oder_header_handel_null
)
,dim_sales_oder_header_underfined_record as (
    SELECT
        sales_order_id
        ,order_date
        ,customer_id
        ,sales_territory_id
        ,sales_person_id
        ,status
        ,bill_to_address_id
        ,ship_to_adrress_id
        ,SubTotal
        ,tax_amount
        ,Freight
    FROM dim_sales_oder_header_cast_type

    UNION ALL

    SELECT
        0 as sales_order_id
        ,TIMESTAMP '1900-01-01' as order_date
        ,0 as customer_id
        ,0 as sales_territory_id
        ,0 as sales_person_id
        ,'Undefiend' as status
        ,0 as bill_to_address_id
        ,0 as ship_to_adrress_id
        ,0.0 as SubTotal
        ,0.0 as tax_amount
        ,0.0 as Freight
)
,dim_sales_oder_header_change_word as (
SELECT
        sales_order_id
        ,order_date
        ,customer_id
        ,sales_territory_id
        ,sales_person_id
        ,CASE
            WHEN status = '1' THEN 'In process'
            WHEN status = '2' THEN 'Approved'
            WHEN status = '3' THEN 'Backordered'
            WHEN status = '4' THEN 'Rejected'
            WHEN status = '5' THEN 'Shipped'
            WHEN status = '6' THEN 'Cancelled'
            ELSE 'Undefiend'
        END as status
        ,bill_to_address_id
        ,ship_to_adrress_id
        ,SubTotal
        ,tax_amount
        ,Freight
        ,(SubTotal + tax_amount + Freight) as total_due
FROM dim_sales_oder_header_underfined_record
)

SELECT
        sales_order_id
        ,order_date
        ,customer_id
        ,sales_territory_id
        ,sales_person_id
        ,status
        ,bill_to_address_id
        ,ship_to_adrress_id
        ,tax_amount
        ,total_due
FROM dim_sales_oder_header_change_word