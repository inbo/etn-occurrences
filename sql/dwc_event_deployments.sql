-- The following network projects are being used in the animal projects of interest:
-- Albertkanaal
-- Bovenschelde
-- BPNS
-- Demer
-- Dijle
-- Leopoldkanaal
-- Maas
-- Saeftinghe
-- Westerschelde 1
-- Westerschelde 2
-- Westerschelde 3
-- Zeeschelde

SELECT

-- Metadata terms:

  'Event'::text as type,
  'en'::text as language,
  'http://creativecommons.org/publicdomain/zero/1.0/'::text as license,
  ''::text as rightsholder,
  'http://www.inbo.be/en/norms-for-data-use'::text as accessRights,
  ''::text as datasetID,
  'Acoustic telemetry data of fish in the Scheldt river basin and the Belgian Part of the North Sea (BPNS)'::text as datasetName,
  ''::text as institutionCode,
  'MachineObservation'::text as basisOfRecord,

-- Taxon Core terms:

  --- eventID
 'urn:catalog:etn:' || projectcode || ':' || id_pk || ':event-receiver-deployment' as eventID,

  --- samplingProtocol
  '' as samplingProtocol,

  --- eventDate
    CASE
      WHEN recover_date_time IS NULL THEN (to_char(deploy_date_time, 'YYYY-MM-DD'))::text
      ELSE (
          to_char(deploy_date_time, 'YYYY-MM-DD') ||
          '/' ||
          to_char(recover_date_time, 'YYYY-MM-DD')
          )::text
      END AS eventDate,

  --- locatlity
  station_name::text as locality,

  --- decimalLatitude
  ROUND(deploy_lat::numeric,5) as decimalLatitude,

  --- decimalLongitude
  ROUND(deploy_long::numeric,5) as decimalLongitude,

  --- eventRemarks
 CASE
  WHEN recover_lat IS NOT NULL THEN
    ('recover latitude: ' || ROUND(recover_lat::numeric,5) || ' | ' ||
    'recover longitude: ' || ROUND(recover_long::numeric,5) || ' | ' ||
    'location name: ' || location_name || ' | ' ||
    'location description: ' || COALESCE(location_description, 'NA'))::text
  ELSE
     ('location name: ' || location_name || ' | ' ||
    'location description: ' || COALESCE(location_description, 'NA'))::text
  END AS eventRemarks

FROM vliz.deployments_view AS deployments

  WHERE projectcode = 'albert'
      OR projectcode = 'bovenschelde'
      OR projectcode = 'bpns'
      OR projectcode = 'demer'
      OR projectcode = 'dijle'
      OR projectcode = 'leopoldkanaal'
      OR projectcode = 'maas'
      OR projectcode = 'saeftinghe'
      OR projectcode = 'ws1'
      OR projectcode = 'ws2'
      OR projectcode = 'ws3'


