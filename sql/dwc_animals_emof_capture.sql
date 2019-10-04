
SELECT
   'urn:catalog:etn:' || projectcode || ':' || id_pk || ':event-capture' as eventID,
   'urn:catalog:etn:' || projectcode || ':' || id_pk || ':occurrence-capture' as occurrenceID,
   measurementType,
   measurementValue,
   measurementUnit


FROM (

  -- Length data

    SELECT
      *,
      length_type::text as measurementType,
      length::text as measurementValue,
      length_units::text as measurementUnit

    FROM vliz.animals_view
    WHERE length IS NOT NULL

  UNION ALL

  -- Length 2 data

    SELECT
      *,
      length2_type::text as measurementType,
      length2::text as measurementValue,
      length2_units::text as measurementUnit

    FROM vliz.animals_view
    WHERE length2 IS NOT NULL

  UNION ALL

  -- Length 3 data

    SELECT
      *,
      length3_type::text as measurementType,
      length3::text as measurementValue,
      length3_units::text as measurementUnit

    FROM vliz.animals_view
    WHERE length3 IS NOT NULL

  UNION ALL

  -- Length 4 data

    SELECT
      *,
      length4_type::text as measurementType,
      length4::text as measurementValue,
      length4_units::text as measurementUnit

    FROM vliz.animals_view
    WHERE length4 IS NOT NULL

  UNION ALL

  -- Weight

    SELECT
      *,
     'weight'::text as measurementType,
      weight::text as measurementValue,
      weight_units::text as measurementUnit

    FROM vliz.animals_view
    WHERE weight_units IS NOT NULL

  UNION ALL

  -- Life stage

    SELECT
      *,
     'life stage'::text as measurementType,
      life_stage::text as measurementValue,
      'durif life stage'::text as measurementUnit

    FROM vliz.animals_view
    WHERE life_stage IS NOT NULL

  UNION ALL

  -- Age

    SELECT
      *,
     'age'::text as measurementType,
      age::text as measurementValue,
      age_units::text as measurementUnit

    FROM vliz.animals_view
    WHERE age IS NOT NULL

  UNION ALL

  -- Sex

    SELECT
      *,
     'sex'::text as measurementType,
      sex::text as measurementValue,
      ''::text as measurementUnit

    FROM vliz.animals_view
    WHERE sex IS NOT NULL

  UNION ALL

  -- Origin

    SELECT
      *,
     'origin'::text as measurementType,
      wild_or_hatchery::text as measurementValue,
      ''::text as measurementUnit

    FROM vliz.animals_view
    WHERE wild_or_hatchery IS NOT NULL

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
ORDER BY eventid

