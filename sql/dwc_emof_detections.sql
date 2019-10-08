
SELECT
   'etn:' || network_project_code || ':' || deployment_fk || ':event-receiver-deployment'::text as eventID,
   'etn:' || animal_project_code || ':' || animal_id_pk || ':' || id_pk || ':occurrence-detection'::text as occurrenceID,
   measurementType,
   measurementValue,
   measurementUnit

FROM (

  SELECT
    network_project_code, animal_project_code, deployment_fk, animal_id_pk, id_pk,
    'transmitter sensor value'::text as measurementType,
    sensor_value::text as measurementValue,
    sensor_unit::text as measurementUnit
  FROM vliz.detections_view
  WHERE sensor_value IS NOT NULL

) as x

WHERE animal_id_pk = {animal_id}



