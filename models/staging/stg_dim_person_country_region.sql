WITH dim_person_country_region_source as (
    SELECT * 
    FROM `adventureworks2019.Person.CountryRegion`
)

,dim_person_country_rename as (
    SELECT
        CountryRegionCode as conuntry_region_id
        ,Name as conuntry_region_name
    FROM dim_person_country_region_source
)

,dim_person_country_cast_type as (
    SELECT
        cast(conuntry_region_id as string) as conuntry_region_id
        ,cast(conuntry_region_name as string) as conuntry_region_name
    FROM dim_person_country_rename
)

,dim_person_country_underfined_record as (
    SELECT
        conuntry_region_id
        ,conuntry_region_name
    FROM dim_person_country_cast_type

    UNION ALL

    SELECT
      'Undefined' as conuntry_region_id
      ,'Undefined' as conuntry_region_name
)

SELECT
     conuntry_region_id
    ,conuntry_region_name
FROM dim_person_country_underfined_record