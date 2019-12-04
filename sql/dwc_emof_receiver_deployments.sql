SELECT
  -- eventID
  -- eventID includes a reference to the specific network project and the identifier of the specific receiver deployment (id_pk) involved in the detection occurrence
 'etn:' || projectcode || ':' || id_pk || ':' || 'event-receiver-deployment' AS eventID,

  measurementType,
  measurementValue,
  measurementUnit

FROM (
  -- receiver id
  SELECT
    projectcode,
    id_pk,
    'receiver id'::text AS measurementType,
    receiver::text AS measurementValue,
    ''::text AS measurementUnit
  FROM vliz.deployments_view

  UNION ALL

  -- receiver status
  SELECT
    projectcode,
    id_pk,
    'receiver status'::text AS measurementType,
    CASE
      WHEN receiver_status = 'Active' THEN 'active'::text
      WHEN receiver_status = 'Available' THEN 'available'::text
      WHEN receiver_status = 'Lost' THEN 'lost'::text
      WHEN receiver_status = 'Broken' THEN 'broken'::text
      WHEN receiver_status = 'Returned to manufacturer' THEN 'returned to manufacturer'::text
    END AS measurementValue,
    ''::text AS measurementUnit
  FROM vliz.deployments_view

  UNION ALL

  -- receiver type
  SELECT
    d.projectcode,
    d.id_pk,
    'receiver type'::text AS measurementType,
    CASE
      WHEN r.receiver_type = 'acoustic_telemetry' THEN 'acoustic telemetry'::text
    END AS measurementValue,
    ''::text AS measurementUnit
  FROM  vliz.deployments_view AS d
    JOIN vliz.receivers AS r
      ON (d.receiver_fk = r.id_pk)

  UNION ALL

  -- receiver bottom depth
  SELECT
    projectcode,
    id_pk,
    'receiver bottom depth'::text AS measurementType,
    bottom_depth AS measurementValue,
    'm'::text AS measurementUnit
  FROM vliz.deployments_view
  WHERE bottom_depth IS NOT NULL

  UNION ALL

  -- intended coordinates
  SELECT
    projectcode,
    id_pk,
    'receiver intended coordinates'::text AS measurementType,
    (
      'latitude: '  || ROUND(intended_lat::numeric,5) || ', '
      'longitude: ' || ROUND(intended_long::numeric,5)
    )::text AS measurementValue,
    ''::text AS measurementUnit
  FROM vliz.deployments_view
  WHERE intended_lat IS NOT NULL

  UNION ALL

  -- drop dead date
  SELECT
    projectcode,
    id_pk,
    'receiver drop dead date'::text AS measurementType,
    (to_char(drop_dead_date, 'YYYY-MM-DD'))::text AS measurementValue,
    ''::text AS measurementUnit
  FROM vliz.deployments_view
  WHERE drop_dead_date IS NOT NULL

  UNION ALL

  -- Time interval between the recording of temperature statistic
  SELECT
    projectcode,
    id_pk,
    'time interval between recording of temperature statistic'::text AS measurementType,
    log_temperature_stats_period::text AS measurementValue,
    's'::text AS measurementUnit
  FROM vliz.deployments_view
  WHERE log_temperature_stats_period IS NOT NULL

  UNION ALL

  -- Time interval between the sample values of temperature
  SELECT
    projectcode,
    id_pk,
    'time interval between the sample values of temperature'::text AS measurementType,
    log_temperature_sample_period::text AS measurementValue,
    's'::text AS measurementUnit
  FROM vliz.deployments_view
  WHERE log_temperature_sample_period IS NOT NULL

  UNION ALL

  -- Time interval between the recording of noise statistic
  SELECT
    projectcode,
    id_pk,
    'time interval between the recording of noise statistic'::text AS measurementType,
    log_noise_stats_period::text AS measurementValue,
    's'::text AS measurementUnit
  FROM vliz.deployments_view
  WHERE log_noise_stats_period IS NOT NULL

  UNION ALL

  -- Time interval between the sample values of noise
  SELECT
    projectcode,
    id_pk,
    'time interval between the sample values of noise'::text AS measurementType,
    log_noise_sample_period::text AS measurementValue,
    's'::text AS measurementUnit
  FROM vliz.deployments_view
  WHERE log_noise_sample_period IS NOT NULL

  UNION ALL

  -- Time interval between the recording of depth statistic
  SELECT
    projectcode,
    id_pk,
    'time interval between the recording of depth statistic'::text AS measurementType,
    log_depth_stats_period::text AS measurementValue,
    's'::text AS measurementUnit
  FROM vliz.deployments_view
  WHERE log_depth_stats_period IS NOT NULL

  UNION ALL

  -- Time interval between the sample values of depth
  SELECT
    projectcode,
    id_pk,
    'time interval between the sample values of depth'::text AS measurementType,
    log_depth_sample_period::text AS measurementValue,
    's'::text AS measurementUnit
  FROM vliz.deployments_view
  WHERE log_depth_sample_period IS NOT NULL

  UNION ALL

  -- Time interval between the sample values of tilt
  SELECT
    projectcode,
    id_pk,
    'time interval between the sample values of tilt'::text AS measurementType,
    log_tilt_sample_period::text AS measurementValue,
    's'::text AS measurementUnit
  FROM vliz.deployments_view
    WHERE log_tilt_sample_period IS NOT NULL
) AS x

WHERE
  projectcode IN ({network_projects*})

ORDER BY
  eventID
