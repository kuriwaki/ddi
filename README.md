d.d.i. (Data Defect Index) for non i.i.d. Samples
================

A simple set of functions to implements Meng’s Data Defect Index
(d.d.i.).

> Xiao-Li Meng. 2018. “Statistical paradises and paradoxes in big data
> (I): Law of large populations, big data paradox, and the 2016 US
> presidential election.” Annals of Applied Statistics 12:2, 685–726.
> <https://doi.org/10.1214/18-AOAS1161SF>.

([ungated
version](https://statistics.fas.harvard.edu/files/statistics-2/files/statistical_paradises_and_paradoxes.pdf))

## Install

``` r
# install.packages("devtools")
remotes::install_github("kuriwaki/ddi")
```

# Usage

With a dataframe with columns for a group’s estimates and components of
the formula, `ddc` computes the data defect correlation (\(\rho\)).

An example dataset from the 2016 Election is included (this also serves
as the replication dataset for the AOAS article). This looks like

``` r
library(ddi)
library(tidyverse)

data(g2016)
g2016
```

    ## # A tibble: 51 x 11
    ##    state st    pct_djt_voters cces_pct_djt_vv cces_pct_djtrun…
    ##    <chr> <chr>          <dbl>           <dbl>            <dbl>
    ##  1 Alab… AL            0.621           0.408            0.428 
    ##  2 Alas… AK            0.513           0.306            0.319 
    ##  3 Ariz… AZ            0.487           0.423            0.445 
    ##  4 Arka… AR            0.606           0.416            0.434 
    ##  5 Cali… CA            0.316           0.285            0.305 
    ##  6 Colo… CO            0.433           0.350            0.371 
    ##  7 Conn… CT            0.409           0.294            0.318 
    ##  8 Dela… DE            0.419           0.329            0.349 
    ##  9 Dist… DC            0.0409          0.0575           0.0690
    ## 10 Flor… FL            0.490           0.403            0.422 
    ## # … with 41 more rows, and 6 more variables: cces_totdjt_vv <dbl>,
    ## #   votes_djt <dbl>, tot_votes <dbl>, cces_n_vv <dbl>, vap <dbl>,
    ## #   vep <dbl>

We can compute the data defect correlation just by plugging in some
numbers. For
example

``` r
ddc(mu = 62984824/136639786, muhat = 12284/35829, N = 136639786, n = 35829)
```

    ## [1] -0.003837163

and the d.d.i. is the square of that, about 0.0000147.

we got these numbers by

``` r
select(g2016, cces_totdjt_vv, cces_n_vv, tot_votes, votes_djt) %>%
  summarize_all(sum)
```

    ## # A tibble: 1 x 4
    ##   cces_totdjt_vv cces_n_vv tot_votes votes_djt
    ##            <dbl>     <dbl>     <dbl>     <dbl>
    ## 1          12284     35829 136639786  62984824

where

  - `cces_totdjt_vv`: The count of Trump voters (among validated voters)
  - `cces_n_vv`: The count of CCES valiated voters (sample size)
  - `votes_djt`: Total votes for Trump
  - `tot_votes`: Total turnout
  - `cces_pct_djt_vv`: Estiamted vote share, `cces_totdjt_vv /
    cces_n_vv`
  - `pct_djt_voters`: Estiamted vote share, `votes_djt / tot_votes`

The function also takes vectors as inputs:

``` r
with(g2016, ddc(mu = pct_djt_voters,
                muhat = cces_pct_djt_vv, 
                N = tot_votes, 
                n = cces_n_vv))
```

    ##  [1] -0.0059541279 -0.0062341071 -0.0023488019 -0.0061097707 -0.0009864919
    ##  [6] -0.0025746344 -0.0035362241 -0.0033951165  0.0014015382 -0.0029747918
    ## [11] -0.0038228152 -0.0001757426 -0.0073716139 -0.0036437192 -0.0069956521
    ## [16] -0.0058255411 -0.0059093759 -0.0057837854 -0.0040533230 -0.0047893714
    ## [21] -0.0024905368 -0.0028280876 -0.0050296619 -0.0043292576 -0.0056626724
    ## [26] -0.0069305025 -0.0046563153 -0.0075840944 -0.0047785897 -0.0037497506
    ## [31] -0.0028289070 -0.0025619899 -0.0031936586 -0.0051968951 -0.0078308914
    ## [36] -0.0057088185 -0.0065654840 -0.0030642004 -0.0039137353 -0.0039907269
    ## [41] -0.0040871158 -0.0069019981 -0.0050741833 -0.0044884762 -0.0059634270
    ## [46] -0.0034491625 -0.0040918085 -0.0024121681 -0.0075404659 -0.0051378753
    ## [51] -0.0086086072

so can be implemented in a tibble as well:

``` r
transmute(g2016, st,
          ddc = ddc(mu = pct_djt_voters, 
                    muhat = cces_pct_djt_vv, 
                    N = tot_votes,
                    n = cces_n_vv))
```

    ## # A tibble: 51 x 2
    ##    st          ddc
    ##    <chr>     <dbl>
    ##  1 AL    -0.00595 
    ##  2 AK    -0.00623 
    ##  3 AZ    -0.00235 
    ##  4 AR    -0.00611 
    ##  5 CA    -0.000986
    ##  6 CO    -0.00257 
    ##  7 CT    -0.00354 
    ##  8 DE    -0.00340 
    ##  9 DC     0.00140 
    ## 10 FL    -0.00297 
    ## # … with 41 more rows

A negative \(\rho\) means
\(\rho = \text{Cor}(\textit{Respond}, \textit{Trump Supporter}) < 0\),
i.e. Trump supporters were less likely to respond.
