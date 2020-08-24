SELECT
  -- eventID
  -- eventID includes a reference to the specific animal project and the identifier of the specific animal (id_pk) involved in the capture occurrence
  eventid,

  -- occurrenceID
  -- occurrenceID includes a reference to the specific animal project and the identifier of the specific animal (id_pk) involved in the capture occurrence
  'etn:' || projectcode || ':' || id_pk || ':occurrence-capture' AS occurrenceID,

  -- eventDate
  to_char(catched_date_time, 'YYYY-MM-DD"T"HH24:MI:SS"Z"') AS eventDate,

  -- scientificName
  scientific_name::text AS scientificName,

  -- kingdom
  'Animalia'::text AS kingdom,

  -- vernacularName
  common_name::text AS vernacularName,

  -- sex
  sex::text AS sex,

  -- taxonRank
  'species'::text AS taxonRank

FROM (
  -- Generates the eventID for the capture, surgery and release event:

  -- Capture event
  SELECT
    'etn:' || projectcode || ':' || id_pk || ':event-capture' AS eventID,
    *
  FROM vliz.animals_view

  UNION ALL

  -- Surgery event
  SELECT
    'etn:' || projectcode || ':' || id_pk || ':event-surgery' AS eventID,
    *
  FROM vliz.animals_view

  UNION ALL

  -- Release event
  SELECT
    'etn:' || projectcode || ':' || id_pk || ':event-release' AS eventID,
    *
  FROM vliz.animals_view

) AS x

WHERE
  id_pk IN ({animal_ids*})
