# utils-models.R
# CFA model specifications for the WHOQOL-BREF tutorial.
# Each function returns a lavaan model syntax string.

#' Population model based on Lin and Yao (2022) meta-analysis
#'
#' Used for Dynamic Fit Index (DFI) and a priori power analysis.
#' Assumes equidistant thresholds for ordinal items (5-point Likert).
#'
#' @return Character string with lavaan model syntax.
specify_pop_model <- function() {
  "
  # Factor loadings from Lin and Yao (2022) meta-analysis
  psycho      =~ 0.92*Q5_P + 0.81*Q6_P + 0.94*Q7_P + 0.73*Q11_P +
                  0.75*Q19_P + 0.63*Q26_P
  physical    =~ 0.84*Q3_F + 0.83*Q4_F + 0.63*Q10_F + 0.71*Q15_F +
                  0.68*Q16_F + 0.89*Q17_F + 0.61*Q18_F
  social      =~ 0.94*Q20_S + 0.89*Q21_S + 0.78*Q22_S
  environment =~ 0.37*Q8_A + 0.49*Q9_A + 0.79*Q12_A + 0.81*Q13_A +
                  0.77*Q14_A + 0.75*Q23_A + 0.64*Q24_A + 0.73*Q25_A

  # Residual correlation between Q4 and Q3
  Q4_F ~~ 0.3*Q3_F

  # Factor variances = 1; inter-factor correlations = 0.3
  # (Lin & Yao reported correlations from 0.08 to 0.3)
  psycho      ~~ 1*psycho + 0.3*physical + 0.3*social + 0.3*environment
  physical    ~~ 1*physical + 0.3*social + 0.3*environment
  social      ~~ 1*social + 0.3*environment
  environment ~~ 1*environment

  # Residual variances (1 - loading^2), except Q3/Q4 (correlated residuals)
  Q5_P  ~~ 0.15*Q5_P
  Q6_P  ~~ 0.34*Q6_P
  Q7_P  ~~ 0.12*Q7_P
  Q11_P ~~ 0.47*Q11_P
  Q19_P ~~ 0.44*Q19_P
  Q26_P ~~ 0.6*Q26_P
  Q10_F ~~ 0.6*Q10_F
  Q15_F ~~ 0.5*Q15_F
  Q16_F ~~ 0.54*Q16_F
  Q17_F ~~ 0.21*Q17_F
  Q18_F ~~ 0.63*Q18_F
  Q20_S ~~ 0.12*Q20_S
  Q21_S ~~ 0.21*Q21_S
  Q22_S ~~ 0.39*Q22_S
  Q8_A  ~~ 0.86*Q8_A
  Q9_A  ~~ 0.76*Q9_A
  Q12_A ~~ 0.38*Q12_A
  Q13_A ~~ 0.34*Q13_A
  Q14_A ~~ 0.41*Q14_A
  Q23_A ~~ 0.44*Q23_A
  Q24_A ~~ 0.59*Q24_A
  Q25_A ~~ 0.47*Q25_A

  # Equidistant thresholds for 5-point Likert scale
  Q5_P  | -1.2*t1 + -0.4*t2 + 0.4*t3 + 1.2*t4
  Q6_P  | -1.2*t1 + -0.4*t2 + 0.4*t3 + 1.2*t4
  Q7_P  | -1.2*t1 + -0.4*t2 + 0.4*t3 + 1.2*t4
  Q11_P | -1.2*t1 + -0.4*t2 + 0.4*t3 + 1.2*t4
  Q19_P | -1.2*t1 + -0.4*t2 + 0.4*t3 + 1.2*t4
  Q26_P | -1.2*t1 + -0.4*t2 + 0.4*t3 + 1.2*t4
  Q3_F  | -1.2*t1 + -0.4*t2 + 0.4*t3 + 1.2*t4
  Q4_F  | -1.2*t1 + -0.4*t2 + 0.4*t3 + 1.2*t4
  Q10_F | -1.2*t1 + -0.4*t2 + 0.4*t3 + 1.2*t4
  Q15_F | -1.2*t1 + -0.4*t2 + 0.4*t3 + 1.2*t4
  Q16_F | -1.2*t1 + -0.4*t2 + 0.4*t3 + 1.2*t4
  Q17_F | -1.2*t1 + -0.4*t2 + 0.4*t3 + 1.2*t4
  Q18_F | -1.2*t1 + -0.4*t2 + 0.4*t3 + 1.2*t4
  Q20_S | -1.2*t1 + -0.4*t2 + 0.4*t3 + 1.2*t4
  Q21_S | -1.2*t1 + -0.4*t2 + 0.4*t3 + 1.2*t4
  Q22_S | -1.2*t1 + -0.4*t2 + 0.4*t3 + 1.2*t4
  Q8_A  | -1.2*t1 + -0.4*t2 + 0.4*t3 + 1.2*t4
  Q9_A  | -1.2*t1 + -0.4*t2 + 0.4*t3 + 1.2*t4
  Q12_A | -1.2*t1 + -0.4*t2 + 0.4*t3 + 1.2*t4
  Q13_A | -1.2*t1 + -0.4*t2 + 0.4*t3 + 1.2*t4
  Q14_A | -1.2*t1 + -0.4*t2 + 0.4*t3 + 1.2*t4
  Q23_A | -1.2*t1 + -0.4*t2 + 0.4*t3 + 1.2*t4
  Q24_A | -1.2*t1 + -0.4*t2 + 0.4*t3 + 1.2*t4
  Q25_A | -1.2*t1 + -0.4*t2 + 0.4*t3 + 1.2*t4
  "
}

#' Four correlated factors model (with Q5)
#'
#' Original 4-factor model including all items.
#' Items Q3, Q4, Q26 already reversed. Q4-Q3 residual correlation included.
#'
#' @return Character string with lavaan model syntax.
specify_4f_model <- function() {
  "
  psycho      =~ Q5_P + Q6_P + Q7_P + Q11_P + Q19_P + Q26_P
  physical    =~ Q3_F + Q4_F + Q10_F + Q15_F + Q16_F + Q17_F + Q18_F
  social      =~ Q20_S + Q21_S + Q22_S
  environment =~ Q8_A + Q9_A + Q12_A + Q13_A + Q14_A + Q23_A + Q24_A + Q25_A
  Q4_F ~~ Q3_F
  "
}

#' Bifactor model (without Q5)
#'
#' General factor (QOL) loads on all items; group factors are orthogonal.
#' Q5 removed due to convergence problems.
#' The general factor must be specified first.
#'
#' @return Character string with lavaan model syntax.
specify_bifactor_model <- function() {
  "
  QOL         =~ Q6_P + Q7_P + Q11_P + Q19_P + Q26_P +
                  Q3_F + Q4_F + Q10_F + Q15_F + Q16_F + Q17_F + Q18_F +
                  Q20_S + Q21_S + Q22_S +
                  Q8_A + Q9_A + Q12_A + Q13_A + Q14_A + Q23_A + Q24_A + Q25_A
  psycho      =~ Q6_P + Q7_P + Q11_P + Q19_P + Q26_P
  physical    =~ Q3_F + Q4_F + Q10_F + Q15_F + Q16_F + Q17_F + Q18_F
  social      =~ Q20_S + Q21_S + Q22_S
  environment =~ Q8_A + Q9_A + Q12_A + Q13_A + Q14_A + Q23_A + Q24_A + Q25_A
  "
}

#' Second-order model (without Q5)
#'
#' Four first-order factors load on a second-order QOL factor.
#' Psycho variance fixed to 0 to resolve convergence issues.
#' Q5 removed for comparability with the bifactor model.
#'
#' @return Character string with lavaan model syntax.
specify_second_order_model <- function() {
  "
  psycho      =~ Q6_P + Q7_P + Q11_P + Q19_P + Q26_P
  physical    =~ Q3_F + Q4_F + Q10_F + Q15_F + Q16_F + Q17_F + Q18_F
  social      =~ Q20_S + Q21_S + Q22_S
  environment =~ Q8_A + Q9_A + Q12_A + Q13_A + Q14_A + Q23_A + Q24_A + Q25_A
  QOL =~ psycho + physical + social + environment
  Q3_F ~~ Q4_F
  psycho ~~ 0*psycho
  "
}

#' Four correlated factors model without Q5
#'
#' Same as specify_4f_model() but Q5 excluded for comparability.
#'
#' @return Character string with lavaan model syntax.
specify_4f_no_q5_model <- function() {
  "
  psycho      =~ Q6_P + Q7_P + Q11_P + Q19_P + Q26_P
  physical    =~ Q3_F + Q4_F + Q10_F + Q15_F + Q16_F + Q17_F + Q18_F
  social      =~ Q20_S + Q21_S + Q22_S
  environment =~ Q8_A + Q9_A + Q12_A + Q13_A + Q14_A + Q23_A + Q24_A + Q25_A
  Q4_F ~~ Q3_F
  "
}
