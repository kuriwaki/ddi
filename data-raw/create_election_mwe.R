library(tidyverse)

df <- readRDS("~/Dropbox/poll_error/data/output/df_joined.rds")

g2016 <- df %>%
  select(state, st, pct_djt_voters,
         cces_totdjt_vv, cces_pct_djt_vv, cces_pct_djtrund_vv,
         votes_djt, tot_votes, cces_n_vv,
         vap, vep)


usethis::use_data(g2016, overwrite = TRUE)
