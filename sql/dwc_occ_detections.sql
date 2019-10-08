
SELECT
   'etn:' || network_project_code || ':' || deployment_fk || ':event-receiver-deployment'::text as eventID,
   'etn:' || animal_project_code || ':' || animal_id_pk || ':' || id_pk || ':occurrence-detection'::text as occurrenceID,
   to_char(datetime, 'YYYY-MM-DD"T"HH24:MI:SS"Z"') as eventDate,
   scientific_name::text as scientificName,
   'Animalia'::text as kingdom,

FROM vliz.detections_view

WHERE animal_id_pk = {animal_id}



