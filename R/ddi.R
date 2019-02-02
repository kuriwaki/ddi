#' Data Defect Correlation
#'
#' The Data Defect Correlation (d.d.c.) is simply the square root of d.d.i. d.d.c.
#' is the correlation between response and group memembership. Currently both variables
#' are binary. Squaring the d.d.c. is more useful for characterizing the asymptotics of
#' MSE.
#'
#' @param data dataframe
#' @param N variable name (char) for population size. Default assumes \code{"N"}
#' @param n variable name (char) for sample size. Default assumes \code{"n"}
#' @param mu variable name (char) for population quantity of interest
#' @param muhat variable name (char) for sample estimate
#'
#' @export
#'
#' @references Meng, Xiao-Li. Statistical paradises and paradoxes in big data (I):
#' Law of large populations, big data paradox, and the 2016 US presidential election.
#' Ann. Appl. Stat. 12 (2018), no. 2, 685--726. \url{http://doi.org/10.1214/18-AOAS1161SF}
#'
#'
ddc <- function(data = df, N = "N", n = "n", mu,  muhat, cv = NULL) {


  N <- data[[N]]
  n <- data[[n]]
  mu <- data[[mu]]
  muhat <- data[[muhat]]
  if (!is.null(cv)) cv <- data[[cv]]

  ## parts
  one_over_sqrtN <- 1 / sqrt(N)
  diff_mu <- muhat - mu
  f <- n / N
  one_minus_f <- 1 - f
  s2hat <- mu * (1 - mu)
  if (!is.null(cv)) {
    A <- sqrt(1 + (cv^2 / one_minus_f))
    one_over_A <- 1 /A
  }


  ## estimate of rho
  if (!is.null(cv))
    return(one_over_A* one_over_sqrtN * diff_mu / sqrt((one_minus_f / n) * s2hat))

  if (is.null(cv))
    return(one_over_sqrtN * diff_mu / sqrt((one_minus_f / n) * s2hat))
}
