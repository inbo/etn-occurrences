
SELECT
   'urn:catalog:etn:' || network_project_code || ':' || deployment_fk || ':occurrence-detections'::text as eventID,
   'urn:catalog:etn:' || animal_project_code || ':' || animal_id_pk || ':' || 'id_pk' || ':occurrence-detections'::text as occurrenceID,
   ''::text as recordedBy,
   scientific_name::text as scientificName,
   'Animalia'::text as kingdom,
   'Chordata'::text as phylum,
   animal_common_name::text as vernacularName,
   'species'::text as taxonRank

FROM vliz.detections_view

WHERE animal_id_pk = {animal_id}

LIMIT 10



