
SELECT
  eventID,
  occurrenceID,
  person_id::text as recordedBy,
  scientific_name::text as scientificName,
  'Animalia'::text as kingdom,
  'Chordata'::text as phylum,
  common_name::text as vernacularName,
  'species'::text as taxonRank

FROM (

  (SELECT

  -- Capture event

    'urn:catalog:etn:' || projectcode || ':' || id_pk || ':event-capture' as eventID,
    'urn:catalog:etn:' || projectcode || ':' || id_pk || ':occurrence-capture' as occurrenceID,
    *

  FROM vliz.animals_view

  UNION ALL

  SELECT

  -- Surgery event

    'urn:catalog:etn:' || projectcode || ':' || id_pk || ':event-surgery' as eventID,
    'urn:catalog:etn:' || projectcode || ':' || id_pk || ':occurrence-capture' as occurrenceID,
    *

  FROM vliz.animals_view

  UNION ALL

  SELECT

-- Release event

  'urn:catalog:etn:' || projectcode || ':' || id_pk || ':event-release' as eventID,
  'urn:catalog:etn:' || projectcode || ':' || id_pk || ':occurrence-capture' as occurrenceID,
  *


 FROM vliz.animals_view

  )

) AS x


    WHERE

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
