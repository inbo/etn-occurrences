download_detections <- function(sql_file, download_directory, animal_ids,
                         connection, overwrite = FALSE) {
  # Check input arguments
  if (!file.exists(sql_file)) {
    stop("No such sql_file: ", sql_file)
  }

  if (!file.exists(download_directory)) {
    stop("No such directory: ", download_directory)
  }

  # Loop over animal_ids
  for (animal_id in animal_ids) {
    # Create file name
    detections_file = file.path(download_directory, paste0("dwc_occ_detections_", animal_id, ".csv"))

    # Query and download data
    if (file.exists(detections_file) && !overwrite) {
      print(paste(animal_id, ": ", detections_file, "already exists, skipping download"))
    } else {
      print(paste(animal_id, ": downloading data"))
      detections_sql <- glue_sql(read_file(sql_file), .con = connection)
      detections <- tryCatch({
        dbGetQuery(con, detections_sql)
      }, error = function(e) {
        return(NA)
      })

      if (nrow(detections) != 0 && is.na(detections)) {
        # detections = NA will be the case if there was an error in SQL conn.
        # break loop and don't write to file
        break
      } else {
        write_csv(detections, path = detections_file, na = "")
      }
    }
  }
}
