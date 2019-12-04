SELECT
  -- Metadata terms:
  'Event'::text AS type,
  to_char(d.date_modified, 'YYYY-MM-DD"T"HH24:MI:SS"Z"') AS modified,
  'en'::text AS language,
  'http://creativecommons.org/publicdomain/zero/1.0/'::text AS license,
  etn.name::text AS rightsholder,
  ''::text AS datasetID,
  'Acoustic telemetry data of fish in the Scheldt river basin and the Belgian Part of the North Sea (BPNS)'::text AS datasetName,
  etn.name::text AS institutionCode,
  'MachineObservation'::text AS basisOfRecord,

  -- Event Core terms:
  -- eventID
  -- eventID includes a reference to the specific network project and the identifier of the specific receiver deployment (d.id_pk)
 'etn:' || d.projectcode || ':' || d.id_pk || ':event-receiver-deployment' AS eventID,

  -- samplingProtocol
 'receiver deployment' AS samplingProtocol,

  -- eventDate
  CASE
    WHEN d.recover_date_time IS NULL
      THEN (
        to_char(d.deploy_date_time, 'YYYY-MM-DD"T"HH24:MI:SS"Z"')
      )::text
    ELSE (
      to_char(d.deploy_date_time, 'YYYY-MM-DD"T"HH24:MI:SS"Z"') ||
      '/' ||
      to_char(d.recover_date_time, 'YYYY-MM-DD"T"HH24:MI:SS"Z"')
    )::text
  END AS eventDate,

  -- eventRemarks
  -- eventRemarks combines information on the recover latitude and longitude (when provided) of the receiver, and detailed information about the location of the receiver deployment
  CASE
    WHEN d.recover_lat IS NOT NULL
      THEN (
        'recover latitude: ' || ROUND(d.recover_lat::numeric,5) || ' | ' ||
        'recover longitude: ' || ROUND(d.recover_long::numeric,5) || ' | ' ||
        'location name: ' || d.location_name || ' | ' ||
        'location description: ' || COALESCE(d.location_description, 'NA')
      )::text
    ELSE (
      'location name: ' || d.location_name || ' | ' ||
      'location description: ' || COALESCE(d.location_description, 'NA')
    )::text
  END AS eventRemarks,

  -- locality
  d.station_name::text AS locality,

  -- decimalLatitude
  ROUND(d.deploy_lat::numeric,5) AS decimalLatitude,

  -- decimalLongitude
  ROUND(d.deploy_long::numeric,5) AS decimalLongitude,

  -- geodeticDatum
  'WGS84'::text AS geodeticDatum,

  -- coordinateUncertaintyInMeters
  30::numeric AS coordinateUncertaintyInMeters

FROM vliz.deployments_view AS d
  JOIN vliz.receivers AS r
    ON (d.receiver_fk = r.id_pk)
  JOIN vliz.etn_group AS etn
    ON (r.owner_group_fk = etn.id_pk)

--- Select on specific network projects:
WHERE
  projectcode IN ({network_projects*})

ORDER BY
  eventID
