SELECT

-- Metadata terms:

  'Event'::text as type,
  to_char(d.date_modified, 'YYYY-MM-DD"T"HH24:MI:SS"Z"') as modified,
  'en'::text as language,
  'http://creativecommons.org/publicdomain/zero/1.0/'::text as license,
  etn.name::text as rightsholder,
  ''::text as datasetID,
  'Acoustic telemetry data of fish in the Scheldt river basin and the Belgian Part of the North Sea (BPNS)'::text as datasetName,
  etn.name::text as institutionCode,
  'MachineObservation'::text as basisOfRecord,

-- Event Core terms:

  --- eventID
 'etn:' || d.projectcode || ':' || d.id_pk || ':event-receiver-deployment' as eventID,

  --- samplingProtocol
 'receiver deployment' as samplingProtocol,

  --- eventDate
    CASE
      WHEN d.recover_date_time IS NULL THEN (to_char(d.deploy_date_time, 'YYYY-MM-DD"T"HH24:MI:SS"Z"'))::text
      ELSE (
          to_char(d.deploy_date_time, 'YYYY-MM-DD"T"HH24:MI:SS"Z"') ||
          '/' ||
          to_char(d.recover_date_time, 'YYYY-MM-DD"T"HH24:MI:SS"Z"')
          )::text
      END AS eventDate,

  --- eventRemarks

 CASE
  WHEN d.recover_lat IS NOT NULL THEN
    ('recover latitude: ' || ROUND(d.recover_lat::numeric,5) || ' | ' ||
    'recover longitude: ' || ROUND(d.recover_long::numeric,5) || ' | ' ||
    'location name: ' || d.location_name || ' | ' ||
    'location description: ' || COALESCE(d.location_description, 'NA'))::text
  ELSE
     ('location name: ' || d.location_name || ' | ' ||
    'location description: ' || COALESCE(d.location_description, 'NA'))::text
  END AS eventRemarks,

  --- locality
  d.station_name::text as locality,

  --- decimalLatitude
  ROUND(d.deploy_lat::numeric,5) as decimalLatitude,

  --- decimalLongitude
  ROUND(d.deploy_long::numeric,5) as decimalLongitude,

  --- geodeticDatum
  'WGS84'::text as geodeticDatum,

  --- coordinateUncertaintyInMeters
  30::numeric as coordinateUncertaintyInMeters

FROM vliz.deployments_view AS d
  JOIN vliz.receivers AS r ON (d.receiver_fk = r.id_pk)
  JOIN vliz.etn_group AS etn ON (r.owner_group_fk = etn.id_pk)

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

ORDER BY eventID
