download_data <- function(sql_file, download_directory,
                          download_filename = "movebank", animal_ids,
                          shared = FALSE, connection, overwrite = FALSE) {
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
    data_file = file.path(download_directory, paste0(download_filename, "_", animal_id, ".csv"))

    # Query and download data
    if (file.exists(data_file) && !overwrite) {
      print(paste(animal_id, ": ", data_file, "already exists, skipping download"))
    } else {
      print(paste(animal_id, ": downloading data"))
      data_sql <- glue_sql(read_file(sql_file), .con = connection)
      tryCatch({
        data <- dbGetQuery(connection, data_sql)
        write_csv(data, path = data_file, na = "")
      }, error = function(e) {
        stop(e)
      })
    }
  }
}
