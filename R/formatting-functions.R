#' Formatting and Summary Functions for CFA Analysis
#'
#' Utility functions for extracting, formatting, and displaying
#' CFA results from lavaan objects. Designed for use in the
#' CFA-BRM tutorial manuscript.

#' Extract Selected Fit Indices from a lavaan Object
#'
#' @param fit A fitted lavaan object.
#' @param indices Character vector of fit index names.
#' @param digits Number of decimal places for rounding.
#' @return A named numeric vector of fit indices.
#' @examples
#' extract_fit_indices(est_4fa)
#' extract_fit_indices(est_4fa, indices = c("srmr", "rmsea.scaled"))
extract_fit_indices <- function(fit,
                                indices = c("chisq.scaled", "df.scaled",
                                            "pvalue.scaled", "srmr",
                                            "rmsea.scaled", "rmsea.ci.lower.scaled",
                                            "rmsea.ci.upper.scaled",
                                            "cfi.scaled", "tli.scaled"),
                                digits = 3) {
  vals <- lavaan::fitmeasures(fit, indices)
  round(vals, digits)
}

#' Create a Comparison Table of Fit Indices for Multiple Models
#'
#' @param ... Named lavaan fit objects (e.g., `4F = est_4fa, Bifactor = est_4f_bi`).
#' @param indices Character vector of fit index names.
#' @param digits Number of decimal places for rounding.
#' @return A data.frame with models as rows and fit indices as columns.
#' @examples
#' compare_fit(
#'   `4-Factor` = est_4fa,
#'   `Bifactor` = est_4f_bi,
#'   `Second-Order` = est_4f_2or
#' )
compare_fit <- function(...,
                        indices = c("srmr", "rmsea.scaled", "cfi.scaled"),
                        digits = 3) {
  models <- list(...)
  results <- lapply(models, function(fit) {
    extract_fit_indices(fit, indices = indices, digits = digits)
  })
  df <- as.data.frame(do.call(rbind, results))
  df$Model <- names(models)
  df <- df[, c("Model", indices)]
  rownames(df) <- NULL
  df
}

#' Format a Reliability Table from semTools::reliability()
#'
#' @param fit A fitted lavaan object.
#' @param digits Number of decimal places for rounding.
#' @return A data.frame with reliability coefficients.
#' @examples
#' format_reliability(est_4fa)
format_reliability <- function(fit, digits = 3) {
  rel <- semTools::reliability(fit)
  as.data.frame(round(rel, digits))
}

#' Extract Standardized Factor Loadings from a lavaan Object
#'
#' @param fit A fitted lavaan object.
#' @param digits Number of decimal places for rounding.
#' @return A data.frame with columns: lhs, op, rhs, std.all.
#' @examples
#' extract_loadings(est_4fa)
extract_loadings <- function(fit, digits = 3) {
  params <- lavaan::standardizedSolution(fit)
  loadings <- params[params$op == "=~", c("lhs", "rhs", "est.std", "se", "pvalue")]
  loadings$est.std <- round(loadings$est.std, digits)
  loadings$se <- round(loadings$se, digits)
  loadings$pvalue <- round(loadings$pvalue, digits)
  names(loadings) <- c("Factor", "Item", "Std.Loading", "SE", "p")
  rownames(loadings) <- NULL
  loadings
}

#' Extract Top Modification Indices
#'
#' @param fit A fitted lavaan object.
#' @param n_top Number of top modification indices to return.
#' @param min_value Minimum MI value to include.
#' @return A data.frame with modification indices sorted by value.
#' @examples
#' extract_top_mi(est_4fa, n_top = 10)
extract_top_mi <- function(fit, n_top = 20, min_value = 3.84) {
  mi <- lavaan::modificationindices(fit, sort. = TRUE,
                                     minimum.value = min_value,
                                     maximum.number = n_top)
  mi
}
