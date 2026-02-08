# utils-fit.R
# Functions for extracting and comparing CFA fit metrics.

#' Extract key fit indices from a lavaan model
#'
#' @param fit A fitted lavaan object.
#' @param indices Character vector of fit index names.
#' @return Named numeric vector of fit indices.
extract_fit <- function(fit,
                        indices = c("srmr", "rmsea.scaled", "cfi.scaled")) {
  lavaan::fitmeasures(fit, indices)
}

#' Build a comparison table of fit indices across models
#'
#' @param ... Named lavaan fit objects (e.g., `4F = est_4fa, Bifactor = est_bi`).
#' @param indices Character vector of fit index names.
#' @return A data.frame with one row per model.
compare_fit <- function(...,
                        indices = c("srmr", "rmsea.scaled", "cfi.scaled")) {
  fits <- list(...)
  rows <- lapply(names(fits), function(nm) {
    vals <- extract_fit(fits[[nm]], indices)
    data.frame(Model = nm, as.data.frame(as.list(vals)),
               row.names = NULL, check.names = FALSE)
  })
  do.call(rbind, rows)
}
