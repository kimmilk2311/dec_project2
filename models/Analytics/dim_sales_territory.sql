SELECT
    dim_sales_terrtitory.territory_id
    ,dim_sales_terrtitory.territory_name
    ,dim_person_country_region.conuntry_region_id
    ,dim_person_country_region.conuntry_region_name
    ,dim_sales_terrtitory.group_name
FROM
    {{ref("stg_dim_sales_territory")}} as dim_sales_terrtitory
    LEFT JOIN {{ref("stg_dim_person_country_region")}} as dim_person_country_region
        ON dim_sales_terrtitory.conuntry_region_id = dim_person_country_region.conuntry_region_id