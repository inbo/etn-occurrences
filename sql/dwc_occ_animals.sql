
SELECT

-- eventID
--- eventID includes a reference to the specific animal project and the identifier of the specific animal (id_pk) involved in the capture occurrence
  eventid,

-- occurrenceID
--- occurrenceID includes a reference to the specific animal project and the identifier of the specific animal (id_pk) involved in the capture occurrence
  'etn:' || projectcode || ':' || id_pk || ':occurrence-capture' as occurrenceID,

-- eventDate
  to_char(catched_date_time, 'YYYY-MM-DD"T"HH24:MI:SS"Z"') as eventDate,

-- scientificName
  scientific_name::text as scientificName,

-- kingdom
  'Animalia'::text as kingdom,

-- vernacularName
  common_name::text as vernacularName,

-- sex
  sex::text as sex,

-- taxonRank
  'species'::text as taxonRank

FROM

-- Generates the eventID for the capture, surgery and release event:

  (
  SELECT

  -- Capture event

    'etn:' || projectcode || ':' || id_pk || ':event-capture' as eventID,
    *

  FROM vliz.animals_view

  UNION ALL

  SELECT

  -- Surgery event

    'etn:' || projectcode || ':' || id_pk || ':event-surgery' as eventID,
    *

  FROM vliz.animals_view

  UNION ALL

  SELECT

-- Release event

  'etn:' || projectcode || ':' || id_pk || ':event-release' as eventID,
  *


 FROM vliz.animals_view

) AS x


    WHERE

    --- Specify animal projects of interest:

      (projectcode = '2011_rivierprik'
        OR projectcode = '2012_leopoldkanaal'
        OR projectcode = '2013_albertkanaal'
        OR projectcode = '2014_demer'
        OR projectcode = '2015_dijle'
        OR (projectcode = '2015_phd_verhelst' AND scientific_name = 'Anguilla anguilla')
        OR projectcode = 'homarus'
        OR projectcode = 'phd_reubens')
      AND NOT scientific_name = 'Sentinel'
      AND NOT scientific_name = 'Sync tag'
