WITH dim_product_unit_measure_source as (
    SELECT * 
    FROM `adventureworks2019.Production.UnitMeasure`
)

,dim_product_unit_measure_rename as (
    SELECT 
        UnitMeasureCode as unit_measure_id
        ,Name as unit_measure_name
    FROM dim_product_unit_measure_source
)

,dim_product_unit_measure_cast_type as (
    SELECT 
        CAST(unit_measure_id as string ) as unit_measure_id
        ,CAST(unit_measure_name as string) as unit_measure_name
    FROM dim_product_unit_measure_rename
)

SELECT 
    unit_measure_id
    ,unit_measure_name
FROM dim_product_unit_measure_cast_type