WITH dim_human_resources_employee_source as (
    SELECT * 
    FROM `adventureworks2019.HumanResources.Employee`
)

,dim_human_resources_employee_rename as (
    SELECT 
        BusinessEntityID as sales_person_id
        ,JobTitle as jobtitle
        ,Gender as gender
    FROM dim_human_resources_employee_source
)

,dim_human_resources_employee_handel_null as (
  SELECT
    sales_person_id
    ,CASE
        WHEN jobtitle = 'NULL' THEN NULL
        ELSE jobtitle
    END as jobtitle
    ,CASE 
        WHEN gender = 'NULL' THEN NULL
        ELSE gender
    END as gender
  FROM dim_human_resources_employee_rename
    )
,dim_human_resources_employee_cast_type as (
    SELECT
        cast(sales_person_id as integer ) as sales_person_id
        ,cast(jobtitle as string) as jobtitle
        ,cast(gender as string) as gender
    FROM dim_human_resources_employee_handel_null
)

,dim_human_resources_employee_underfined_record as (
    SELECT
        sales_person_id
        ,jobtitle
        ,gender
    FROM dim_human_resources_employee_cast_type

    UNION ALL 

    SELECT
        0 as sales_person_id
        ,'Undefined' as bonus
        ,'Undefined' as commission
)

SELECT
        sales_person_id
        ,jobtitle
        ,CASE
            WHEN gender = 'M' THEN 'Male'
            WHEN gender = 'F' THEN 'Female'
            ELSE 'Undefiend'
        END as gender
FROM dim_human_resources_employee_underfined_record
