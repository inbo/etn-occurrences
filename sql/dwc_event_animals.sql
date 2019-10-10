
-- We map the capture, surgery and release events separately and paste them together in one large dataset

WITH union_event_animals AS(

SELECT *


FROM (

      SELECT
      date_modified,
      owner_organization,
      projectcode,
      scientific_name,

      --- eventID
      ---- eventID integrates a reference to the animal project and the identifier of the specific animal (id_pk)
      'etn:' || projectcode || ':' || id_pk || ':event-capture' as eventID,

      --- samplingProtocol
      capture_method::text as samplingProtocol,

      --- eventDate
      to_char(catched_date_time, 'YYYY-MM-DD"T"HH24:MI:SS"Z"') as eventDate,

      --- locality
      CASE
        WHEN capture_location = 'Genk'
          OR capture_location = 'Upstream draining channel Genk'
          OR capture_location = 'sluis Genk'
          OR capture_location = 'Shipping lock Genk'
          OR capture_location = 'shipping lock Genk'
            THEN 'Shipping lock Genk'::text
        WHEN capture_location = 'Diepenbeek'
          OR capture_location = 'Upstream drainage channel Diepenbeek'
            THEN 'Shipping lock Diepenbeek'
        WHEN capture_location = 'Hasselt'
          OR capture_location = 'Upstream drainage channel Hasselt'
            THEN 'Shipping lock Hasselt'
        ELSE capture_location::text
      END AS locality,

      --- decimalLatitude
      CASE
        WHEN capture_location = 'hatchery Erezée' THEN 50.30605
        WHEN capture_location = 'Upstream draining channel Genk'
          OR capture_location = 'sluis Genk'
          OR capture_location = 'Shipping lock Genk'
            THEN 50.93564
        WHEN capture_location = 'Diepenbeek'
          OR capture_location = 'Upstream drainage channel Diepenbeek'
            THEN 50.93803
        WHEN capture_location = 'Hasselt'
          OR capture_location = 'Upstream drainage channel Hasselt'
            THEN 50.93803
        ELSE ROUND(capture_latitude::numeric,5)
      END AS decimalLatitude,

       --- decimalLongitude
      CASE
        WHEN capture_location = 'hatchery Erezée' THEN 5.54259
        WHEN capture_location = 'Upstream draining channel Genk'
          OR capture_location = 'sluis Genk'
          OR capture_location = 'Shipping lock Genk'
            THEN 5.49701
        WHEN capture_location = 'Diepenbeek'
          OR capture_location = 'Upstream drainage channel Diepenbeek'
            THEN 5.43731
        WHEN capture_location = 'Hasselt'
          OR capture_location = 'Upstream drainage channel Hasselt'
            THEN 5.43731
        ELSE ROUND(capture_longitude::numeric,5)
      END AS decimalLongitude


      FROM vliz.animals_view

    UNION ALL

    -- Surgery event:

    SELECT

      date_modified,
      owner_organization,
      projectcode,
      scientific_name,

       --- eventID
       ---- eventID integrates a reference to the animal project and the identifier of the specific animal (id_pk)

      'etn:' || projectcode || ':' || id_pk || ':event-surgery' as eventID,

       --- samplingProtocol
      'surgery'::text as samplingProtocol,

      --- eventDate
      CASE
        WHEN date_of_surgery IS NULL
          THEN to_char(catched_date_time, 'YYYY-MM-DD"T"HH24:MI:SS"Z"')
        ELSE to_char(date_of_surgery, 'YYYY-MM-DD"T"HH24:MI:SS"Z"')
        END AS eventDate
        ,

      --- locality
      CASE
        WHEN capture_location = 'hatchery Erezée' THEN capture_location::text
        WHEN capture_location = 'Genk'
          OR capture_location = 'Upstream draining channel Genk'
          OR capture_location = 'sluis Genk'
          OR capture_location = 'Shipping lock Genk'
          OR capture_location = 'shipping lock Genk'
            THEN 'Shipping lock Genk'::text
        WHEN capture_location = 'Diepenbeek'
          OR capture_location = 'Upstream drainage channel Diepenbeek'
            THEN 'Shipping lock Diepenbeek'
        WHEN capture_location = 'Hasselt'
          OR capture_location = 'Upstream drainage channel Hasselt'
            THEN 'Shipping lock Hasselt'
        WHEN surgery_location IS NULL THEN capture_location
        ELSE surgery_location::text
        END AS locality
        ,

        --- decimalLatitude
        CASE
          WHEN capture_location = 'hatchery Erezée' THEN 50.30605
          WHEN capture_location = 'Genk'
          OR capture_location = 'Upstream draining channel Genk'
          OR capture_location = 'sluis Genk'
          OR capture_location = 'Shipping lock Genk'
            THEN 50.93564
          WHEN capture_location = 'Diepenbeek'
            OR capture_location = 'Upstream drainage channel Diepenbeek'
              THEN 50.93803
          WHEN capture_location = 'Hasselt'
            OR capture_location = 'Upstream drainage channel Hasselt'
              THEN 50.93803
          WHEN surgery_latitude IS NULL THEN ROUND(capture_latitude::numeric,5)
          ELSE ROUND(surgery_latitude::numeric,5)
          END AS decimalLatitude
          ,

        --- decimallongitude
        CASE
            WHEN capture_location = 'hatchery Erezée' THEN 5.54259
            WHEN capture_location = 'Genk'
              OR capture_location = 'Upstream draining channel Genk'
              OR capture_location = 'sluis Genk'
              OR capture_location = 'Shipping lock Genk'
                THEN 5.49701
            WHEN capture_location = 'Diepenbeek'
              OR capture_location = 'Upstream drainage channel Diepenbeek'
                THEN 5.43731
            WHEN capture_location = 'Hasselt'
              OR capture_location = 'Upstream drainage channel Hasselt'
                THEN 5.43731
            WHEN surgery_longitude IS NULL THEN ROUND(capture_longitude::numeric,5)
            ELSE ROUND(surgery_longitude::numeric,5)
            END AS decimalLongitude

    FROM vliz.animals_view

    UNION ALL

    -- Release event:

    SELECT

      date_modified,
      owner_organization,
      projectcode,
      scientific_name,

        --- eventID
        ---- eventID integrates a reference to the animal project and the identifier of the specific animal (id_pk)

        'etn:' || projectcode || ':' || id_pk || ':event-release' as eventID,

        --- samplingProtocol
        'release'::text as samplingProtocol,

        --- eventDate
        to_char(utc_release_date_time, 'YYYY-MM-DD"T"HH24:MI:SS"Z"') AS eventDate,

        --- locality
        CASE
          WHEN release_location = 'Genk' THEN 'Upstream shipping lock Genk'::text
          WHEN release_location = 'Diepenbeek' THEN 'Upstream shipping lock Diepenbeek'::text
          WHEN release_location = 'Hasselt' THEN 'Upstream shipping lock Hasselt'::text
          WHEN projectname = '2013 Albertkanaal' AND release_location iS NULL THEN capture_location::text
        ELSE release_location::text
        END AS locality
        ,

        --- decimalLatitude
        CASE
          WHEN projectname = '2013 Albertkanaal' AND release_location iS NULL THEN ROUND(capture_latitude::numeric, 5)
        ELSE ROUND(release_latitude::numeric, 5)
        END AS decimalLatitude
        ,

        --- decimalLongitude
        CASE
          WHEN projectname = '2013 Albertkanaal' AND release_location iS NULL THEN ROUND(capture_longitude::numeric, 5)
        ELSE ROUND(release_longitude::numeric, 5)
        END AS decimalLongitude

    FROM vliz.animals_view

    ) as full_dataset

-- Select on specific animal projects and scientific names:

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


    )


SELECT

--- Metadata terms:

  'Event'::text as type,
  to_char(date_modified, 'YYYY-MM-DD"T"HH24:MI:SS"Z"') as modified,
  'en'::text as language,
  'http://creativecommons.org/publicdomain/zero/1.0/'::text as license,
  owner_organization::text as rightsholder,
  owner_organization::text as institutionCode,
  ''::text as datasetID,
  'Acoustic telemetry data of fish in the Scheldt river basin and the Belgian Part of the North Sea (BPNS)'::text as datasetName,
  'HumanObservation'::text as basisOfRecord,

--- Event core terms (generated earlier in this script):
  eventID,
  samplingProtocol,
  eventDate,
  locality,
  decimalLatitude,
  decimalLongitude,
  'WGS84'::text as geodeticDatum,
  30::numeric as coordinateUncertaintyInMeters

FROM union_event_animals

ORDER BY eventid
