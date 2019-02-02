#' 2016 General Election
#'
#' Information about Donald Trump's voteshare in each U.S. state,
#' with survey estimates from the Cooperative Congressional Election Study.
#'
#' A dataset containing the prices and other attributes of almost 54,000
#' diamonds.
#'
#' @format A data frame with 51 rows (all U.S. states and D.C.)
#' \describe{
#'   \item{state}{state name}
#'   \item{st}{state name, abbreviation}
#'   \item{pct_djt_voters}{Donald J. Trump's voteshare, the estimand}
#'   \item{cces_pct_djt_vv}{CCES unweighted proportion of Trump support, one possible estimate}
#'   \item{cces_pct_djtrund_vv}{CCES unweighted proportion counting Republican undecideds as Trump voters}
#'   \item{voted_djt}{Total number of votes by Trump}
#'   \item{tot_votes}{Turnout in Presidential race}
#'   \item{cces_n_vv}{Validated voters in survey sample. Sample size for estimate}
#'   \item{vap}{Voting Age Population}
#'   \item{vep}{Voting Elgible Population}
#'   ...
#' }
#' @source \url{https://github.com/kuriwaki/poll_error}. For an explanation in the
#' context of d.d.i., see Meng 2018 (\url{http://doi.org/10.1214/18-AOAS1161SF})
"g2016"
