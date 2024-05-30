#### day 2 code ####

# load packages -----------------------------------------------------------

library(tidyverse)

# BES data ----------------------------------------------------------------

# load data
load("data/bes.Rda")

# number of rows
bes |> nrow()

# compute mean, median and mode
bes$age |> mean()
bes$left_right |> median()
mean(bes$age)

bes |> 
  count(turnout)

n_turnout <- table(bes$turnout)

n_turnout[which.max(n_turnout)]

# mode function
my_mode <- function(x){
  
  tab <- table(x)
  
  tab_max <- tab[which.max(tab)]
  
  return(tab_max)
  
}

my_mode(bes$sex)

# summarising the whole data frame
bes |> 
  summarise(
    across(.cols = where(is.numeric),
           .fn = median)
  )

# manually
bes |> 
  summarise(
    mean_age = mean(age),
    median_age = median(age)
  )

# summarise by group (voters vs non-voters)
bes |> 
  summarise(
    mean_age = mean(age),
    median_age = median(age),
    .by = c(turnout, education)
  ) |> 
  arrange(turnout, education)

# with filtering
bes |> 
  filter(sex == "Female") |> 
  summarise(
    mean_age = mean(age),
    median_age = median(age),
    .by = turnout
  )

# factors -----------------------------------------------------------------

tibble(
  id = c(1,2,3,4),
  education = c("GCSE", "zero", "GCSE", "undergrad")
) |> 
  mutate(
    education_factor = factor(education, levels = c("zero","GCSE","undergrad"))
  ) |> 
  arrange(desc(education_factor))


# standard deviation ------------------------------------------------------

bes |> 
  summarise(
    mean_age = mean(age),
    sd_age = sd(age),
    .by = turnout
  )

bes |> 
  summarise(
    across(
      .cols = where(is.numeric),
      .fns = list(mean = mean,
                  sd = sd)
    )
  )

bes_women <- bes |> 
  filter(sex == "Female")

bes_women |> 
  summarise(
    mean_age = mean(age)
  )

# histograms --------------------------------------------------------------

bes |> 
  ggplot(aes(x = age)) +
  geom_histogram() +
  facet_wrap(~turnout, dir = "v")

bes |> 
  ggplot(aes(x = age)) +
  geom_histogram(aes(fill = turnout), 
                 position = "dodge",
                 alpha = 0.6) +
  theme_minimal()

# density
bes |> 
  ggplot(aes(x = age)) +
  geom_density()

# correlation -------------------------------------------------------------

cor(bes$age, bes$left_right)

bes |> 
  select(where(is.numeric)) |> 
  cor()

# ATE ---------------------------------------------------------------------

load("data/nhis.Rda")

nhis |> nrow()
nhis |> ncol()
nhis |> str()

# difference in means
mean(nhis[nhis$insured == TRUE, "health"])-
mean(nhis[nhis$insured == FALSE, "health"])

nhis |> 
  summarise(
    health = mean(health),
    .by = insured
  ) |> 
  summarise(
    diff = diff(health)
  )

# check balance in NHIS data
nhis |> 
  summarise(
    across(.cols = everything(),
           .fns = mean),
    .by = insured
  )

# rand data ---------------------------------------------------------------

load("data/rand.Rda")

rand |> nrow()
rand |> ncol()
rand |> str()
rand |> summary()

rand |> 
  summarise(
    mean_health = mean(health),
    .by = insured
  ) |> 
  summarise(
    diff = diff(mean_health)
  )

# balance
rand |> 
  summarise(
    across(.cols = everything(),
           .fns = ~mean(.))
  )

rand |> 
  drop_na() |> 
  nrow()

rand |> 
  summarise(
    across(.cols = everything(),
           .fns = ~mean(., na.rm = T)),
    .by = insured
  )

lm(
  data = rand,
  formula = health ~ insured
) |> 
  summary()

