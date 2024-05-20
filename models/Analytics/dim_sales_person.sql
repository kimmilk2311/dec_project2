SELECT
    dim_sales_person.sales_person_id
    ,dim_person.person_title as sales_person_title
    ,dim_person.person_first_name as first_name
    ,dim_person.person_middle_name as middle_name
    ,dim_person.person_last_name as last_name
    ,dim_sales_person.bonus 
    ,dim_human_resources_employee.jobtitle as job_title
    ,dim_human_resources_employee.gender 
    ,dim_sales_person.commission
FROM 
    {{ref("stg_dim_sales_person")}} as dim_sales_person
    LEFT JOIN {{ref("stg_dim_person")}} as dim_person 
        ON dim_sales_person.sales_person_id = dim_person.person_id
    LEFT JOIN {{ref("stg_dim_human_resources_employee")}} as dim_human_resources_employee
        ON dim_sales_person.sales_person_id = dim_human_resources_employee.sales_person_id