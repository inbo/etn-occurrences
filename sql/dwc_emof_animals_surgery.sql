SELECT
 'etn:' || projectcode || ':' || id_pk || ':event-surgery' as eventID,
 '' as occurrenceID,
  measurementType,
  measurementValue,
  measurementUnit

FROM (

    -- Anaesthetic concentration

    SELECT
          projectcode, scientific_name, id_pk,
          ('anaesthetic:' || ' ' || anaesthetic)::text as measurementType,
         CASE
            WHEN anaesthetic_concentration = '0.02 ml/L' THEN SUBSTR(anaesthetic_concentration, 1, 4)::text
            ELSE SUBSTR(anaesthetic_concentration, 1, 3)::text
            END AS measurementValue,
          'ml/l'::text as measurementUnit

    FROM vliz.animals_view
    WHERE anaesthetic_concentration IS NOT NULL

  UNION ALL

    -- Treatment type

    SELECT
          projectcode, scientific_name, id_pk,
         'treatment type'::text as measurementType,
         CASE
          WHEN treatment_type::text = 'INTERNAL TAGGING' THEN 'internal tagging'
          WHEN treatment_type::text = 'EXTERNAL TAGGING' THEN 'external tagging'
         END AS measurementValue,
         ''::text as measurementUnit

    FROM vliz.animals_view
    WHERE treatment_type IS NOT NULL

  UNION ALL

    -- Tag full ID

    SELECT
          projectcode, scientific_name, id_pk,
         'tag identifier'::text as measurementType,
         tag_full_id::text as measurementValue,
         ''::text as measurementUnit

    FROM vliz.animals_view
    WHERE tag_full_id IS NOT NULL

  UNION ALL

    -- Tag manufacturer

    SELECT
          projectcode, scientific_name, id_pk,
         'tag manufacturer'::text as measurementType,
         manufacturer::text as measurementValue,
         ''::text as measurementUnit

    FROM vliz.animals_view
    WHERE manufacturer IS NOT NULL

  UNION ALL

    -- Tag serial number

    SELECT
          projectcode, scientific_name, id_pk,
         'tag serial number'::text as measurementType,
         serial_number::text as measurementValue,
         ''::text as measurementUnit

    FROM vliz.animals_view
    WHERE serial_number IS NOT NULL

  UNION ALL

    -- Tag telemetry type

    SELECT
          projectcode, scientific_name, id_pk,
         'telemetry type'::text as measurementType,
         'acoustic'::text as measurementValue,
         ''::text as measurementUnit

    FROM vliz.animals_view
    WHERE type IS NOT NULL

  UNION ALL

    -- Tag model

    SELECT
          projectcode, scientific_name, id_pk,
         'tag model'::text as measurementType,
         model::text as measurementValue,
         ''::text as measurementUnit

    FROM vliz.animals_view
    WHERE model IS NOT NULL

  UNION ALL

    -- Tag sensor type

    SELECT
          a.projectcode, a.scientific_name, a.id_pk,
         'tag sensor type'::text as measurementType,
         CASE
          WHEN t.sensor_type::text = 'A' THEN 'acceleration'
          WHEN t.sensor_type::text = 'P' THEN 'pressure'
          END AS measurementValue,
         ''::text as measurementUnit

    FROM vliz.animals_view as a
      JOIN vliz.tags AS t ON (a.tag_full_id = t.tag_full_id)

    WHERE sensor_type IS NOT NULL

  UNION ALL

    -- Tag status

    SELECT
          a.projectcode, a.scientific_name, a.id_pk,
         'tag status'::text as measurementType,
         t.status::text as measurementValue,
         ''::text as measurementUnit

    FROM vliz.animals_view as a
      JOIN vliz.tags AS t ON (a.tag_full_id = t.tag_full_id)

    WHERE t.status IS NOT NULL

  UNION ALL

    -- Tag estimated lifetime

    SELECT
          a.projectcode, a.scientific_name, a.id_pk,
         'tag estimated lifetime'::text as measurementType,
         t.estimated_lifetime::text as measurementValue,
         'days'::text as measurementUnit

    FROM vliz.animals_view as a
      JOIN vliz.tags AS t ON (a.tag_full_id = t.tag_full_id)

    WHERE t.estimated_lifetime IS NOT NULL

  UNION ALL

    -- Tag emission frequency

    SELECT
          a.projectcode, a.scientific_name, a.id_pk,
         'tag emission frequency'::text as measurementType,
         SUBSTR(t.frequency, 1, 3)::text as measurementValue,
         'kHz'::text as measurementUnit

    FROM vliz.animals_view as a
      JOIN vliz.tags AS t ON (a.tag_full_id = t.tag_full_id)

    WHERE t.frequency IS NOT NULL

) as x

WHERE (projectcode = '2011_rivierprik'
      OR projectcode = '2012_leopoldkanaal'
      OR projectcode = '2013_albertkanaal'
      OR projectcode = '2014_demer'
      OR projectcode = '2015_dijle'
      OR (projectcode = '2015_phd_verhelst' AND scientific_name = 'Anguilla anguilla')
      OR projectcode = 'homarus'
      OR projectcode = 'phd_reubens')
      AND NOT scientific_name = 'Sentinel'
      AND NOT scientific_name = 'Sync tag'

ORDER BY eventid
