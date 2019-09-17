SELECT *
FROM vliz.detections_view
WHERE
  animal_id = {animal_id}
LIMIT 10
