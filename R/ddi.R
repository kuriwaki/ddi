#' Data Defect Correlation
#'
#' The Data Defect Correlation (ddc) is the correlation between response and
#' group membership. It quantifies the correlation between the outcome of interest
#' and the selection  into the sample; when the sample selection is independent
#' across members of the population, the ddc is zero.  Currently both variables
#' are binary. The data defect index (ddi) is the square of ddc. Squaring the
#' d.d.c. is more useful for characterizing the asymptotics of ' MSE.
#'
#' @param mu Vector of population quantity of interest
#' @param muhat Vector for sample estimate
#' @param N Vector of population size
#' @param n Vector of sample size
#' @param cv Coefficient of variation of the weights, if survey weights exist and
#'   \code{muhat} is the weighted proportion. The coefficient of variation is a
#'   summary statistic computed by \code{sd(weights) / mean(weights)}.
#'
#' @return A vector of d.d.c. of the same length of the input, or a scalar if
#'  all input variables are scalars.
#'
#' @examples
#' library(tibble)
#' library(dplyr)
#'
#' data(g2016)
#'
#' # 1. scalar input
#' select(g2016, cces_pct_djt_vv, cces_n_vv, tot_votes, votes_djt) %>%
#'   summarize_all(sum)
#'
#' ## plug those numbers in
#' ddc(mu = 62984824/136639786, muhat = 12284/35829, N = 136639786, n = 35829)
#'
#' # 2. vector input using "with"
#' with(g2016, ddc(mu = pct_djt_voters, muhat = cces_pct_djt_vv, N = tot_votes, n = cces_n_vv))
#'
#' # 3. vector input in tidy tibble
#' transmute(g2016, st,
#'  ddc = ddc(mu = pct_djt_voters, muhat = cces_pct_djt_vv, N = tot_votes, n = cces_n_vv))
#'
#'
#' @references Meng, Xiao-Li (2018) <doi:10.1214/18-AOAS1161SF>, "Statistical Paradises
#' and Paradoxes in Big Data (I): Law of Large Populations, Big Data Paradox,
#' and the 2016 US Presidential Election." Annals of Applied Statistics 12:2, 685--726.
#'
#'
#'
#' @export
ddc <- function(mu, muhat, N, n, cv = NULL) {

  ## parts
  one_over_sqrtN <- 1 / sqrt(N)
  diff_mu <- muhat - mu

  #  ((1- f) / f) = (N - n)/n "Data Quantity"
  f <- n / N
  one_minus_f <- 1 - f

  ## sigma, "Problem Difficulty"
  s2hat <- mu * (1 - mu)

  # adjustment factor for SEs when there are weights
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
