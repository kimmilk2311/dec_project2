WITH dim_sales_person_source as (
    SELECT *
    FROM `adventureworks2019.Sales.SalesPerson`
)

,dim_sales_person_rename as (
    SELECT 
        BusinessEntityID as sales_person_id
        ,Bonus as bonus
        ,CommissionPct as commission
    FROM dim_sales_person_source
)

,dim_sales_person_cast_type as (
    SELECT
        cast(sales_person_id as integer ) as sales_person_id
        ,cast(bonus as float64) as bonus
        ,cast(commission as float64) as commission
    FROM dim_sales_person_rename
)

,dim_sales_person_underfined_record as (
    SELECT
        sales_person_id
        ,bonus
        ,commission
    FROM dim_sales_person_cast_type
    
    UNION ALL 

    SELECT
        0 as sales_person_id
        ,0.0 as bonus
        ,0.0 as commission
)

SELECT
        sales_person_id
        ,bonus
        ,commission
FROM dim_sales_person_underfined_record
