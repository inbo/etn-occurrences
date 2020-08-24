SELECT
  -- eventID
  -- eventID includes a reference to the specific animal project and the identifier of the specific animal (id_pk) involved in the capture event
  'etn:' || projectcode || ':' || id_pk || ':event-capture' AS eventID,

  -- occurrenecID
  -- occurrenceID includes a reference to the specific animal project and the identifier of the specific animal (id_pk) involved in the capture occurrene
  'etn:' || projectcode || ':' || id_pk || ':occurrence-capture' AS occurrenceID,

  measurementType,
  measurementValue,
  measurementUnit

FROM (
  -- Length data
  SELECT
    *,
    length_type::text AS measurementType,
    length::text AS measurementValue,
    length_units::text AS measurementUnit
  FROM vliz.animals_view
  WHERE length IS NOT NULL

  UNION ALL

  -- Length 2 data
  SELECT
    *,
    length2_type::text AS measurementType,
    length2::text AS measurementValue,
    length2_units::text AS measurementUnit
  FROM vliz.animals_view
  WHERE length2 IS NOT NULL

  UNION ALL

  -- Length 3 data
  SELECT
    *,
    length3_type::text AS measurementType,
    length3::text AS measurementValue,
    length3_units::text AS measurementUnit
  FROM vliz.animals_view
  WHERE length3 IS NOT NULL

  UNION ALL

  -- Length 4 data

  SELECT
    *,
    length4_type::text AS measurementType,
    length4::text AS measurementValue,
    length4_units::text AS measurementUnit

  FROM vliz.animals_view
  WHERE length4 IS NOT NULL

  UNION ALL

  -- Weight
  SELECT
    *,
    'weight'::text AS measurementType,
    weight::text AS measurementValue,
    weight_units::text AS measurementUnit
  FROM vliz.animals_view
  WHERE weight_units IS NOT NULL

  UNION ALL

  -- Life stage
  SELECT
    *,
    'life stage'::text AS measurementType,
    life_stage::text AS measurementValue,
    'durif life stage'::text AS measurementUnit
  FROM vliz.animals_view
  WHERE life_stage IS NOT NULL

  UNION ALL

  -- Age
  SELECT
    *,
    'age'::text AS measurementType,
    age::text AS measurementValue,
    age_units::text AS measurementUnit
  FROM vliz.animals_view
  WHERE age IS NOT NULL

  UNION ALL

  -- Sex
  SELECT
    *,
    'sex'::text AS measurementType,
    sex::text AS measurementValue,
    ''::text AS measurementUnit
  FROM vliz.animals_view
  WHERE sex IS NOT NULL

  UNION ALL

  -- Origin
  SELECT
    *,
    'origin'::text AS measurementType,
    wild_or_hatchery::text AS measurementValue,
    ''::text AS measurementUnit
  FROM vliz.animals_view
  WHERE wild_or_hatchery IS NOT NULL
) AS x

WHERE
  id_pk IN ({animal_ids*})

ORDER BY
  eventid
