# utils-data.R
# Functions for data loading, validation, and column labeling.

#' Load WHOQOL data from Mendeley Data repository
#'
#' Downloads and labels the WHOQOL dataset used in the CFA tutorial.
#' Caches a local copy in `data/` to avoid repeated downloads.
#'
#' @param cache_dir Character. Directory for the local cache (default: "data").
#' @return A data.frame with labelled columns.
load_whoqol_data <- function(cache_dir = here::here("data")) {
  cache_file <- file.path(cache_dir, "WHOQOL_Data.dat")

  if (!file.exists(cache_file)) {
    url_data <- paste0(
      "https://data.mendeley.com/datasets/rdky78bk8r/2/files/",
      "b58a7054-4978-4239-81db-00f9efd86e44/WHOQOL_Data.dat"
    )
    url_labels <- paste0(
      "https://data.mendeley.com/datasets/rdky78bk8r/2/files/",
      "ae2a5c01-2fc2-43e5-b31c-8db8cc5bff8a/WHOQOL_Labels.txt"
    )

    message("Downloading WHOQOL data from Mendeley Data...")
    dir.create(cache_dir, showWarnings = FALSE, recursive = TRUE)
    utils::download.file(url_data, cache_file, mode = "wb", quiet = TRUE)

    labels_file <- file.path(cache_dir, "WHOQOL_Labels.txt")
    utils::download.file(url_labels, labels_file, mode = "wb", quiet = TRUE)
    message("Data cached in: ", cache_dir)
  }

  df <- utils::read.table(cache_file)
  labels <- utils::read.table(file.path(cache_dir, "WHOQOL_Labels.txt"))
  names(df) <- labels$V1

  validate_whoqol(df)

  df
}

#' Validate expected structure of the WHOQOL data
#'
#' @param df A data.frame to validate.
#' @return Invisible TRUE; stops with an error if validation fails.
validate_whoqol <- function(df) {
  expected_items <- c(
    "Q3_F", "Q4_F", "Q5_P", "Q6_P", "Q7_P", "Q8_A", "Q9_A",
    "Q10_F", "Q11_P", "Q12_A", "Q13_A", "Q14_A", "Q15_F", "Q16_F",
    "Q17_F", "Q18_F", "Q19_P", "Q20_S", "Q21_S", "Q22_S", "Q23_A",
    "Q24_A", "Q25_A", "Q26_P"
  )
  missing_items <- setdiff(expected_items, names(df))
  if (length(missing_items) > 0) {
    stop(
      "WHOQOL data is missing expected items: ",
      paste(missing_items, collapse = ", "),
      call. = FALSE
    )
  }
  invisible(TRUE)
}
