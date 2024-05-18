WITH dim_person_source as (
    SELECT * 
    FROM  `adventureworks2019.Person.Person`
)

,dim_person_rename as (
SELECT 
    BusinessEntityID as person_id
    ,Title as person_title
    ,FirstName as person_first_name
    ,MiddleName as person_middle_name
    ,LastName as person_last_name
    ,Suffix as person_suffix
 FROM dim_person_source
)

,dim_person_handel_null as (
SELECT 
   person_id,
   CASE
      WHEN person_title = 'NULL' THEN NULL 
      ELSE person_title
   END as person_title,
   CASE
      WHEN person_first_name = 'NULL' THEN NULL
      ELSE person_first_name
   END as person_first_name,
   CASE
      WHEN person_middle_name = 'NULL' THEN NULL
      ELSE person_middle_name
   END as person_middle_name,
   CASE 
      WHEN person_last_name = 'NULL' THEN NULL 
      ELSE person_last_name
   END as person_last_name,
   CASE 
      WHEN person_suffix = 'NULL' THEN NULL
      ELSE person_suffix
   END as person_suffix,
FROM dim_person_rename
)

,dim_person_cast_type as (
SELECT
    cast(person_id as integer) as  person_id
    ,cast(person_title as string) as person_title
    ,cast(person_first_name as string) as person_first_name
    ,cast(person_middle_name as string) as person_middle_name
    ,cast(person_last_name as string) as person_last_name
    ,cast(person_suffix as string) as person_suffix
FROM dim_person_handel_null
)

,dim_person_underfined_record as (
    SELECT
       person_id
       ,person_title
       ,person_first_name
       ,person_middle_name
       ,person_last_name
       ,person_suffix
    FROM dim_person_cast_type

    UNION ALL

    SELECT 
       0 as person_id
       ,'Undefined' as person_title
       ,'Undefined' as person_first_name
       ,'Undefined' as person_middle_name
       ,'Undefined' as person_last_name
       ,'Undefined' as person_suffix
)

SELECT
        person_id
       ,person_title
       ,person_first_name
       ,person_middle_name
       ,person_last_name
       ,person_suffix
FROM dim_person_underfined_record