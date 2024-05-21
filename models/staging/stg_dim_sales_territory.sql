WITH dim_sales_terrtitory_source as (
    SELECT * 
    FROM `adventureworks2019.Sales.SalesTerritory`
)

,dim_sales_terrtitory_rename as (
    SELECT
    	TerritoryID as territory_id
        ,name as territory_name
        ,CountryRegionCode as conuntry_region_id
        ,`Group` as group_name
    FROM dim_sales_terrtitory_source
)

,dim_sales_terrtitory_handel_null as (
    SELECT 
        territory_id
        ,CASE
            WHEN territory_name = 'NULL' THEN NULL
            ELSE territory_name 
        END as territory_name
        ,CASE 
            WHEN conuntry_region_id = 'NULL' THEN NULL
            ELSE conuntry_region_id 
        END as conuntry_region_id
        ,CASE 
            WHEN group_name = 'NULL' THEN NULL 
            ELSE group_name
        END as group_name
    FROM dim_sales_terrtitory_rename
)

,dim_sales_terrtitory_cast_type as (
    SELECT 
        cast(territory_id as integer) as territory_id
        ,cast(territory_name as string) as territory_name
        ,cast(conuntry_region_id as string) as conuntry_region_id 
        ,cast(group_name as string) as group_name
    FROM dim_sales_terrtitory_handel_null
)

,dim_sales_terrtitory_underfined_record as (
    SELECT
        territory_id
        ,territory_name
        ,conuntry_region_id 
        ,group_name
    FROM dim_sales_terrtitory_cast_type

    UNION ALL 

    SELECT
        0 as territory_id
        ,'Undefined' as territory_name
        ,'Undefined' as conuntry_region_id 
        ,'Undefined' as group_name
)

SELECT
         territory_id
        ,territory_name
        ,conuntry_region_id 
        ,group_name
FROM dim_sales_terrtitory_underfined_record