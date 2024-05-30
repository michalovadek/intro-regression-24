#### day 3 ####

# library -----------------------------------------------------------------

library(tidyverse)


# data --------------------------------------------------------------------

load("data/student_constituencies.Rdata")

# plot
constituencies |> 
  rename(voters = voters_change) |> 
  ggplot(aes(x = students, y = voters)) +
  geom_point() +
  theme_classic()

# histogram of Y
constituencies |> 
  ggplot(aes(x = voters_change)) +
  geom_histogram()

# regression --------------------------------------------------------------

reg_out <- lm(
  data = constituencies,
  formula = voters_change ~ students
)

reg_out |> summary()

# get a nicer table
library(texreg)

reg_out |> 
  screenreg()

# predicted Y
constituencies$yhat <- predict(
  reg_out
)

# plot
constituencies |> 
  ggplot(aes(x = voters_change, y = yhat)) +
  geom_point() +
  geom_abline()

# SSR
sum((constituencies$voters_change - constituencies$yhat)^2)

# plot residuals
plot(constituencies$voters_change - constituencies$yhat)

# newdata
predict(reg_out,
        newdata = data.frame(students = c(10, 30, 50, 80)))


# multiple regression -----------------------------------------------------

# load german data
load("data/german_2017_results.RData")

# assign to new object
german_data <- results

# regression
model_biv <- lm(data = german_data,
                formula = AfD ~ christian)

model_mult <- lm(data = german_data,
                 formula = AfD ~ christian + east)

# show both next to each other
screenreg(list(model_biv, model_mult))

predict(
  model_mult,
  newdata = data.frame(
    christian = c(30),
    east = c(FALSE)
  )
)

install.packages("broom")

model_mult |> 
  broom::tidy()

model_mult |> 
  summary()

# change baseline ---------------------------------------------------------

german_data$region <- fct_relevel(german_data$region,
                                  "BE")

lm(
  data = german_data,
  formula = AfD ~ region
) |> 
  summary()

# Explaining Brexit -------------------------------------------------------

# what caused Brexit?

# load data
brexit <- read.csv("data/brexit.csv")
