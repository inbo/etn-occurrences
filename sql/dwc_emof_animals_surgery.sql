SELECT
  -- eventID
  -- eventID includes a reference to the specific animal project and the identifier of the specific animal (id_pk) involved in the surgery event
 'etn:' || projectcode || ':' || id_pk || ':event-surgery' AS eventID,

  -- occurrenceID
  -- (empty as the emof is linked to an the event core)
 '' AS occurrenceID,

  measurementType,
  measurementValue,
  measurementUnit

FROM (
  -- Anaesthetic concentration
  SELECT
    projectcode,
    scientific_name,
    id_pk,
    ('anaesthetic:' || ' ' || anaesthetic)::text AS measurementType,
    CASE
      WHEN anaesthetic_concentration = '0.02 ml/L' THEN SUBSTR(anaesthetic_concentration, 1, 4)::text
      ELSE SUBSTR(anaesthetic_concentration, 1, 3)::text
    END AS measurementValue,
    'ml/l'::text AS measurementUnit
  FROM vliz.animals_view
  WHERE anaesthetic_concentration IS NOT NULL

  UNION ALL

  -- Treatment type
  SELECT
    projectcode,
    scientific_name,
    id_pk,
    'treatment type'::text AS measurementType,
    CASE
      WHEN treatment_type::text = 'INTERNAL TAGGING' THEN 'internal tagging'
      WHEN treatment_type::text = 'EXTERNAL TAGGING' THEN 'external tagging'
    END AS measurementValue,
    ''::text AS measurementUnit
  FROM vliz.animals_view
  WHERE treatment_type IS NOT NULL

  UNION ALL

  -- Tag full ID
  SELECT
    projectcode,
    scientific_name,
    id_pk,
    'tag identifier'::text AS measurementType,
    tag_full_id::text AS measurementValue,
    ''::text AS measurementUnit
  FROM vliz.animals_view
  WHERE tag_full_id IS NOT NULL

  UNION ALL

  -- Tag manufacturer
  SELECT
    projectcode,
    scientific_name,
    id_pk,
    'tag manufacturer'::text AS measurementType,
    manufacturer::text AS measurementValue,
    ''::text AS measurementUnit
  FROM vliz.animals_view
  WHERE manufacturer IS NOT NULL

  UNION ALL

  -- Tag serial number
  SELECT
    projectcode,
    scientific_name,
    id_pk,
    'tag serial number'::text AS measurementType,
    serial_number::text AS measurementValue,
    ''::text AS measurementUnit
  FROM vliz.animals_view
  WHERE serial_number IS NOT NULL

  UNION ALL

  -- Tag telemetry type
  SELECT
    projectcode,
    scientific_name,
    id_pk,
    'telemetry type'::text AS measurementType,
    'acoustic'::text AS measurementValue,
    ''::text AS measurementUnit
  FROM vliz.animals_view
  WHERE type IS NOT NULL

  UNION ALL

  -- Tag model
  SELECT
    projectcode,
    scientific_name,
    id_pk,
    'tag model'::text AS measurementType,
    model::text AS measurementValue,
    ''::text AS measurementUnit
  FROM vliz.animals_view
  WHERE model IS NOT NULL

  UNION ALL

  -- Tag sensor type
  SELECT
    a.projectcode,
    a.scientific_name,
    a.id_pk,
    'tag sensor type'::text AS measurementType,
    CASE
      WHEN t.sensor_type::text = 'A' THEN 'acceleration'
      WHEN t.sensor_type::text = 'P' THEN 'pressure'
    END AS measurementValue,
    ''::text AS measurementUnit
  FROM vliz.animals_view AS a
    JOIN vliz.tags AS t
      ON (a.tag_full_id = t.tag_full_id)
  WHERE sensor_type IS NOT NULL

  UNION ALL

  -- Tag status
  SELECT
    a.projectcode,
    a.scientific_name,
    a.id_pk,
    'tag status'::text AS measurementType,
    t.status::text AS measurementValue,
    ''::text AS measurementUnit
  FROM vliz.animals_view AS a
    JOIN vliz.tags AS t
    ON (a.tag_full_id = t.tag_full_id)
  WHERE t.status IS NOT NULL

  UNION ALL

  -- Tag estimated lifetime
  SELECT
    a.projectcode,
    a.scientific_name,
    a.id_pk,
    'tag estimated lifetime'::text AS measurementType,
    t.estimated_lifetime::text AS measurementValue,
    'days'::text AS measurementUnit
  FROM vliz.animals_view AS a
    JOIN vliz.tags AS t
      ON (a.tag_full_id = t.tag_full_id)
  WHERE t.estimated_lifetime IS NOT NULL

  UNION ALL

  -- Tag emission frequency
  SELECT
    a.projectcode,
    a.scientific_name,
    a.id_pk,
    'tag emission frequency'::text AS measurementType,
    SUBSTR(t.frequency, 1, 3)::text AS measurementValue,
    'kHz'::text AS measurementUnit
  FROM vliz.animals_view AS a
    JOIN vliz.tags AS t
      ON (a.tag_full_id = t.tag_full_id)
  WHERE t.frequency IS NOT NULL

) AS x

WHERE
  id_pk IN ({animal_ids*})

ORDER BY
  eventid
