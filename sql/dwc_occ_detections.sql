SELECT
   -- eventID
   -- eventID includes a reference to the specific network project and the identifier of the specific receiver deployment (deployment_fk) involved in the detection occurrence
   'etn:' || network_project_code || ':' || deployment_fk || ':event-receiver-deployment'::text AS eventID,

   -- occurreneID
   -- occurrenceID includes a reference to the specific animal project, the identifier of the specific animal (animal_id_pk), and the identifier of the specific detection of that animal (id_pk)
   'etn:' || animal_project_code || ':' || animal_id_pk || ':' || id_pk || ':occurrence-detection'::text AS occurrenceID,

   -- eventDate
   to_char(datetime, 'YYYY-MM-DD"T"HH24:MI:SS"Z"') AS eventDate,

   -- scientificName
   scientific_name::text AS scientificName,

   -- kingdom
   'Animalia'::text AS kingdom

FROM
   vliz.detections_view

WHERE
   animal_id_pk = {animal_id}
