SELECT
    dim_customer.customer_id
    ,dim_customer.is_reseller
    ,dim_customer.store_id
    ,dim_store.store_name
    ,dim_person.person_title
    ,dim_person.person_first_name
    ,dim_person.person_middle_name
    ,dim_person.person_last_name
    ,dim_person.person_suffix
FROM 
   {{ref("stg_dim_customer")}} as dim_customer
    LEFT JOIN {{ref("stg_dim_store")}} as dim_store
        ON dim_customer.store_id = dim_store.store_id
    LEFT JOIN {{ref("stg_dim_person")}} as dim_person 
        ON dim_person.person_id = dim_person.person_id
