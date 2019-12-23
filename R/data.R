#' 2016 General Election Results and Survey Estimates
#'
#' Donald Trump's voteshare in each U.S. state,
#' with survey estimates from the Cooperative Congressional Election Study
#' (pre-election wave). See Meng (2018) referenced below for more details.
#' We focus on unweighted estimates to capture the response patterns, before
#' correcting for any imbalances through weights.
#'
#'
#' @format A data frame with 51 rows (all U.S. states and D.C.)
#' \describe{
#'   \item{state}{state (full name)}
#'   \item{st}{state (abbreviation).}
#'   \item{pct_djt_voters}{Donald J. Trump's voteshare, the estimand.}
#'   \item{cces_pct_djt_vv}{CCES unweighted proportion of Trump support, one estimate.}
#'   \item{cces_pct_djtrund_vv}{CCES unweighted proportion counting Republican undecideds as Trump voters.}
#'   \item{votes_djt}{Total number of votes by Trump.}
#'   \item{tot_votes}{Turnout in Presidential as total number of votes cast.}
#'   \item{cces_totdjt_vv}{Validated voters intending to vote for Trump. Used as the numerator for the above CCES estimates.}
#'   \item{cces_n_vv}{Validated voters in survey sample. Used as the denominator for the above CCES estimates.}
#'   \item{vap}{Voting Age Population in the state.}
#'   \item{vep}{Voting Eligible Population in the state (estimate from the US Election Project).}
#' }
#'
#' @examples
#' library(dplyr)
#' data(g2016)
#'
#' transmute(g2016,
#'           st,
#'           ddc = ddc(mu = pct_djt_voters,
#'                     muhat = cces_pct_djt_vv,
#'                     N = tot_votes,
#'                     n = cces_n_vv))
#'
#' @source  Cooperative Congressional Election Study (CCES) \url{https://cces.gov.harvard.edu/}
#'  and the United States Election Project \url{http://www.electproject.org/2016g}.
#'  Created under \url{https://github.com/kuriwaki/poll_error}.
#'
#'
#' @references   For an explanation in the
#' context of d.d.i., see Meng (2018) <doi:10.1214/18-AOAS1161SF>
"g2016"
