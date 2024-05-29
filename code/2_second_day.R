#### day 2 code ####

# load packages -----------------------------------------------------------

library(tidyverse)

# BES data ----------------------------------------------------------------

# load data
load("data/bes.Rda")

# number of rows
bes |> nrow()

# compute mean, median and mode
# compare voters and non-voters
