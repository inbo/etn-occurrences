SELECT
  -- eventID
  -- eventID includes a reference to the specific network project and the identifier of the specific receiver deployment (deployment_fk) involved in the detection occurrence
  'etn:' || network_project_code || ':' || deployment_fk || ':event-receiver-deployment'::text AS eventID,

  -- occurrenceID
  -- occurrenceID includes a reference to the specific animal project and the identifier of the specific animal (id_pk) involved in the capture occurrence
  'etn:' || animal_project_code || ':' || animal_id_pk || ':' || id_pk || ':occurrence-detection'::text AS occurrenceID,

  -- emof terms:
  measurementType,
  measurementValue,
  measurementUnit

FROM (
  SELECT
  -- Sensor value of transitter:
    network_project_code,
    animal_project_code,
    deployment_fk,
    animal_id_pk,
    id_pk,
    'transmitter sensor value'::text AS measurementType,
    sensor_value::text AS measurementValue,
    sensor_unit::text AS measurementUnit
  FROM vliz.detections_view
  WHERE sensor_value IS NOT NULL
) AS x

WHERE
  animal_id_pk IN ({animal_ids*})
