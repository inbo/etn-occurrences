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

-- Other

SELECT

  'Event'::text as type,
  'en'::text as language,
  'http://creativecommons.org/publicdomain/zero/1.0/'::text as license,
  'INBO'::text as rightsholder,
  'http://www.inbo.be/en/norms-for-data-use'::text as accessRights,
  ''::text as datasetID,
  'Acoustic telemetry data of fish in the Scheldt river basin and the Belgian Part of the North Sea (BPNS)'::text as datasetName,
  'INBO'::text as institutionCode,
  'MachineObservation'::text as basisOfRecord,
  'urn:catalog:etn:receiver:' || receiver_fk || ':event-receiver-deployment' as eventID,
  '' as samplingProtocol,
    CASE
      WHEN recover_date_time IS NULL THEN (to_char(deploy_date_time, 'YYYY-MM-DD'))::text
      ELSE (
          to_char(deploy_date_time, 'YYYY-MM-DD') ||
          '/' ||
          to_char(recover_date_time, 'YYYY-MM-DD')
          )::text
      END AS eventDate,
  '' as locality,
  ROUND(deploy_lat::numeric,5) as decimalLatitude,
  ROUND(deploy_long::numeric,5) as decimalLongitude,
  'WGS84'::text as geodeticDatum,
  30::numeric as coordinateUncertaintyInMeters

FROM vliz.deployments_view AS deployments
WHERE projectcode = 'albert'
  OR projectname = 'bovenschelde'
  OR projectname = 'bpns'
  OR projectname = 'demer'
  OR projectname = 'dijle'
  OR projectname = 'leopoldkanaal'
  OR projectname = 'maas'
  OR projectname = 'saeftinghe'
  OR projectname = 'ws1'
  OR projectname = 'ws2'
  OR projectname = 'ws3'

