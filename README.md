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

An example with the 2016 Election, which looks like

``` r
library(ddi)
library(tidyverse)
```

    ## Warning: package 'tibble' was built under R version 3.5.2

``` r
data(g2016)
g2016
```

    ## # A tibble: 51 x 10
    ##    state st    pct_djt_voters cces_pct_djt_vv cces_pct_djtrun… votes_djt
    ##    <chr> <chr>          <dbl>           <dbl>            <dbl>     <dbl>
    ##  1 Alab… AL            0.621           0.408            0.428    1318255
    ##  2 Alas… AK            0.513           0.306            0.319     163387
    ##  3 Ariz… AZ            0.487           0.423            0.445    1252401
    ##  4 Arka… AR            0.606           0.416            0.434     684872
    ##  5 Cali… CA            0.316           0.285            0.305    4483810
    ##  6 Colo… CO            0.433           0.350            0.371    1202484
    ##  7 Conn… CT            0.409           0.294            0.318     673215
    ##  8 Dela… DE            0.419           0.329            0.349     185127
    ##  9 Dist… DC            0.0409          0.0575           0.0690     12723
    ## 10 Flor… FL            0.490           0.403            0.422    4617886
    ## # … with 41 more rows, and 4 more variables: tot_votes <dbl>,
    ## #   cces_n_vv <dbl>, vap <dbl>, vep <dbl>

Specify the column names for each component:

``` r
ddcs <- ddc(g2016, 
            N = "tot_votes",
            n = "cces_n_vv",
            mu = "pct_djt_voters", 
            muhat = "cces_pct_djt_vv")
```

This returns:

``` r
library(tibble)
print(tibble(st = g2016$st, ddc = ddcs), n = 51)
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
    ## 11 GA    -0.00382 
    ## 12 HI    -0.000176
    ## 13 ID    -0.00737 
    ## 14 IL    -0.00364 
    ## 15 IN    -0.00700 
    ## 16 IA    -0.00583 
    ## 17 KS    -0.00591 
    ## 18 KY    -0.00578 
    ## 19 LA    -0.00405 
    ## 20 ME    -0.00479 
    ## 21 MD    -0.00249 
    ## 22 MA    -0.00283 
    ## 23 MI    -0.00503 
    ## 24 MN    -0.00433 
    ## 25 MS    -0.00566 
    ## 26 MO    -0.00693 
    ## 27 MT    -0.00466 
    ## 28 NE    -0.00758 
    ## 29 NV    -0.00478 
    ## 30 NH    -0.00375 
    ## 31 NJ    -0.00283 
    ## 32 NM    -0.00256 
    ## 33 NY    -0.00319 
    ## 34 NC    -0.00520 
    ## 35 ND    -0.00783 
    ## 36 OH    -0.00571 
    ## 37 OK    -0.00657 
    ## 38 OR    -0.00306 
    ## 39 PA    -0.00391 
    ## 40 RI    -0.00399 
    ## 41 SC    -0.00409 
    ## 42 SD    -0.00690 
    ## 43 TN    -0.00507 
    ## 44 TX    -0.00449 
    ## 45 UT    -0.00596 
    ## 46 VT    -0.00345 
    ## 47 VA    -0.00409 
    ## 48 WA    -0.00241 
    ## 49 WV    -0.00754 
    ## 50 WI    -0.00514 
    ## 51 WY    -0.00861

A negative \(\rho\) means
\(\rho = \text{Cor}(\textit{Respond}, \textit{Trump Supporter}) < 0\),
i.e. Trump supporters were less likely to respond.
