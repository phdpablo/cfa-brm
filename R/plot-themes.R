#' Plot Themes and Visualization Helpers for CFA Analysis
#'
#' Custom themes and helper functions for consistent
#' CFA visualizations in the CFA-BRM tutorial manuscript.

#' Custom semPlot Path Diagram with Consistent Styling
#'
#' Wrapper around semPlot::semPaths with default settings
#' for the CFA-BRM tutorial.
#'
#' @param fit A fitted lavaan object.
#' @param layout Layout type: "tree", "circle", or "tree3".
#' @param bifactor Character name of general factor for bifactor layout, or NULL.
#' @param edge.label.cex Numeric, edge label size.
#' @param label.cex Numeric, node label size.
#' @param node.width Numeric, node width.
#' @param mar Numeric vector of length 4 for margins.
#' @param ... Additional arguments passed to semPaths.
#' @return Invisible NULL (plot produced as side effect).
#' @examples
#' plot_cfa_diagram(est_4fa)
#' plot_cfa_diagram(est_4f_bi, layout = "tree3", bifactor = "QOL")
plot_cfa_diagram <- function(fit,
                             layout = "tree",
                             bifactor = NULL,
                             edge.label.cex = 0.8,
                             label.cex = 1.2,
                             node.width = 0.7,
                             mar = c(3, 1, 3, 1),
                             ...) {
  args <- list(
    object = fit,
    what = "std",
    style = "lisrel",
    layout = layout,
    intercepts = FALSE,
    thresholds = FALSE,
    residuals = FALSE,
    edge.label.cex = edge.label.cex,
    label.cex = label.cex,
    weighted = FALSE,
    edge.color = "black",
    node.width = node.width,
    mar = mar
  )

  if (!is.null(bifactor)) {
    args$bifactor <- bifactor
    args$edge.label.position <- 0.7
  }

  extra <- list(...)
  args <- c(args, extra)

  do.call(semPlot::semPaths, args)
  invisible(NULL)
}
