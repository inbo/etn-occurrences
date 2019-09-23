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
 'urn:catalog:etn:receiver:' || receiver_fk || ':event-receiver-deployment' as eventID,
 CASE
  WHEN recover_date_time IS NULL THEN deploy_date_time AT TIME ZONE 'UTC'
  ELSE to_char(recover_date_time, 'HH12:MI:SS')
  END AS eventDate
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

