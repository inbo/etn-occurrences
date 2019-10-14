SELECT

-- eventID
--- eventID includes a reference to the specific network project and the identifier of the specific receiver deployment (id_pk) involved in the detection occurrence
 'etn:' || projectcode || ':' || id_pk || ':' || 'event-receiver-deployment' as eventID,

  measurementType,
  measurementValue,
  measurementUnit

FROM (

    -- receiver id

    SELECT
          projectcode, id_pk,
          'receiver id'::text as measurementType,
           receiver::text as measurementValue,
           ''::text as measurementUnit

    FROM vliz.deployments_view

  UNION ALL

    -- receiver status

    SELECT
          projectcode, id_pk,
          'receiver status'::text as measurementType,
           CASE
            WHEN receiver_status = 'Active' THEN 'active'::text
            WHEN receiver_status = 'Available' THEN 'available'::text
            WHEN receiver_status = 'Lost' THEN 'lost'::text
            WHEN receiver_status = 'Broken' THEN 'broken'::text
            WHEN receiver_status = 'Returned to manufacturer' THEN 'returned to manufacturer'::text
          END AS measurementValue,
           ''::text as measurementUnit

    FROM vliz.deployments_view

 UNION ALL

    -- receiver type

    SELECT

          d.projectcode, d.id_pk,
          'receiver type'::text as measurementType,
          CASE
            WHEN r.receiver_type = 'acoustic_telemetry' THEN 'acoustic telemetry'::text
            END AS measurementValue,
           ''::text as measurementUnit

    FROM  vliz.deployments_view as d
      JOIN vliz.receivers AS r ON (d.receiver_fk = r.id_pk)

UNION ALL

    -- receiver bottom depth

    SELECT
          projectcode, id_pk,
          'receiver bottom depth'::text as measurementType,
          bottom_depth as measurementValue,
          'm'::text as measurementUnit

    FROM vliz.deployments_view
    WHERE bottom_depth IS NOT NULL

UNION ALL

    -- intended coordinates

    SELECT
          projectcode, id_pk,
          'receiver intended coordinates'::text as measurementType,
          (
            'latitude: '  || ROUND(intended_lat::numeric,5) || ', '
            'longitude: ' || ROUND(intended_long::numeric,5)
          )::text as measurementValue,
          ''::text as measurementUnit

    FROM vliz.deployments_view
    WHERE intended_lat IS NOT NULL

UNION ALL

    -- drop dead date

    SELECT
          projectcode, id_pk,
          'receiver drop dead date'::text as measurementType,
          (to_char(drop_dead_date, 'YYYY-MM-DD'))::text as measurementValue,
          ''::text as measurementUnit

    FROM vliz.deployments_view
    WHERE drop_dead_date IS NOT NULL

UNION ALL

    -- Time interval between the recording of temperature statistic

    SELECT
          projectcode, id_pk,
          'time interval between recording of temperature statistic'::text as measurementType,
          log_temperature_stats_period::text as measurementValue,
          's'::text as measurementUnit

    FROM vliz.deployments_view
    WHERE log_temperature_stats_period IS NOT NULL


UNION ALL

    -- Time interval between the sample values of temperature

    SELECT
          projectcode, id_pk,
          'time interval between the sample values of temperature'::text as measurementType,
          log_temperature_sample_period::text as measurementValue,
          's'::text as measurementUnit

    FROM vliz.deployments_view
    WHERE log_temperature_sample_period IS NOT NULL

UNION ALL

    -- Time interval between the recording of noise statistic

    SELECT
          projectcode, id_pk,
          'time interval between the recording of noise statistic'::text as measurementType,
          log_noise_stats_period::text as measurementValue,
          's'::text as measurementUnit

    FROM vliz.deployments_view
    WHERE log_noise_stats_period IS NOT NULL

UNION ALL

    -- Time interval between the sample values of noise

    SELECT
          projectcode, id_pk,
          'time interval between the sample values of noise'::text as measurementType,
          log_noise_sample_period::text as measurementValue,
          's'::text as measurementUnit

    FROM vliz.deployments_view
    WHERE log_noise_sample_period IS NOT NULL

UNION ALL

    -- Time interval between the recording of depth statistic

    SELECT
          projectcode, id_pk,
          'time interval between the recording of depth statistic'::text as measurementType,
          log_depth_stats_period::text as measurementValue,
          's'::text as measurementUnit

    FROM vliz.deployments_view
    WHERE log_depth_stats_period IS NOT NULL

UNION ALL

    -- Time interval between the sample values of depth

    SELECT
          projectcode, id_pk,
          'time interval between the sample values of depth'::text as measurementType,
          log_depth_sample_period::text as measurementValue,
          's'::text as measurementUnit

    FROM vliz.deployments_view
    WHERE log_depth_sample_period IS NOT NULL

UNION ALL

    -- Time interval between the sample values of tilt

    SELECT
          projectcode, id_pk,
          'time interval between the sample values of tilt'::text as measurementType,
          log_tilt_sample_period::text as measurementValue,
          's'::text as measurementUnit

    FROM vliz.deployments_view
    WHERE log_tilt_sample_period IS NOT NULL

 ) as x

WHERE projectcode = 'albert'
        OR projectcode = 'bovenschelde'
        OR projectcode = 'bpns'
        OR projectcode = 'demer'
        OR projectcode = 'dijle'
        OR projectcode = 'leopold'
        OR projectcode = 'maas'
        OR projectcode = 'saeftinghe'
        OR projectcode = 'ws1'
        OR projectcode = 'ws2'
        OR projectcode = 'ws3'
ORDER BY eventID


