#### first day ####

# addition
99 + 14

1000*12

# cntrl + enter to run
"random text"

# basics ------------------------------------------------------------------

object <- "some text"

anything <- 28313

operation <- 1 + 98

operation

vec <- c(10, 87, 123)
vec

vec_text <- c("asd", "nonsense", "a sentence even")
vec_text

# function
add_one <- function(x){
  
  # x plus one
  y <- x + 1
  
  # return y
  return(y)
  
}

add_one(x = 288)

# function with multiple args
sum_divide <- function(x, arg_1, arg_2){
  
  y <- x + arg_1
  
  y <- y / arg_2
  
  return(y)
  
}

sum_divide(x = 8328, arg_1 = 328, arg_2 = 65) |> 
  round(digits = 1)

# cntrl + shift + M for pipes

# data types
0.19 # numeric (any real number)
"language and stuff" # character / strings
5L # integer (1,2,3,4)
TRUE | FALSE # logical
NA # special! missing value

as.integer(1.23)
as.integer(FALSE)

c(1,2,0.9328, TRUE)
c(TRUE, FALSE, "text", 1) 

text_vectr <- c("sentence nonsense", "dog chasing cars",
                "whatever")

# vectorization demo
nchar(text_vectr)

# subsetting
text_vectr[3] |> 
  nchar()
nchar(text_vectr[3])


# packages ----------------------------------------------------------------

# you only run this once
# install.packages("readxl")

# you run this every session
library(readxl)

fake_data <- read_excel(path = "data/fake_spreadsheet.xlsx")

fake_data

install.packages("tidyverse")

# data frames -------------------------------------------------------------

data.frame(id = c(1,2,3),
           name = c("jim", "emily", "william"))

library(tidyverse)

# tibble
data_people <- tibble(
  id = c(1,2,3),
  name = c("jim", "emily", "william")
)

data_people[2,]
data_people[,1]

# creating columns
data_people$colour <- c("grey","blue","blue")

data_people$colour

library(tidyverse)

data_people$year <- c(1981, 1982, 1989)

# subsetting = filtering
data_people |> 
  filter(year > 1985 |
         colour == "grey")

fake_data <- read_excel(path = "data/fake_spreadsheet.xlsx")

fake_data |> 
  filter(!is.na(flavour))

# strings -----------------------------------------------------------------
# cntrl + shift + R

install.packages("janeaustenr")

library(janeaustenr)

six_books <- janeaustenr::austen_books()

six_books <- six_books |> 
  filter(text != "")

six_books |> 
  filter(str_detect(text, "\\blove\\b"))

six_books |> 
  filter(str_detect(text, "love[:lower:]"))

six_books |> 
  filter(str_detect(text, "[:digit:]{2,}"))

# google stringr cheatsheet

# start of string
six_books |> 
  filter(str_detect(text, "^The "))

# end of string
six_books |> 
  filter(str_detect(text, " and$"))

# extract string
six_books |> 
  mutate(
    digits = str_extract(text, "[:digit:]{4}")
  ) |> 
  filter(digits > 1811)

# count number of book x rows
six_books |> 
  count(book)

# count number of words
summary_words <- six_books |> 
  mutate(
    text = str_squish(text),
    n_words = str_count(text, " ")
  ) |> 
  summarise(
    n_words = sum(n_words),
    .by = book
  )

summary_words

# find a word and count per book
summary_n_man <- six_books |> 
  mutate(
    contains_man = str_detect(text, "\\bman\\b"),
    contains_man = as.integer(contains_man)
  ) |> 
  summarise(
    n_contains_man = sum(contains_man),
    .by = book
  )

summary_n_man |> 
  arrange(-n_contains_man)

# saving stuff to disk
save(summary_n_man, file = "summary_n_man.RData")

# loading back
load(file = "summary_n_man.RData")

summary_n_man

# archaeology long to wide -------------------------------------------------

fake_arch <- read.csv("data/fake_arch_sites.csv")

fake_arch |> 
  mutate(is_site = 1L) |> 
  pivot_wider(names_from = site_type, values_from = is_site)

fake_arch |> 
  mutate(
    after_1975 = ifelse(year_discovery >= 1975, 1, 0)
  ) |> 
  count(site_type, after_1975)

# pdf ---------------------------------------------------------------------

install.packages("pdftools")

library(pdftools)

booker_text <- pdf_text("data/booker_prize.pdf")

booker_text |> cat()


# plotting ----------------------------------------------------------------

fake_arch2 <- fake_arch |> 
  mutate(
    year_positive = ifelse(str_detect(year_founded, "BCE"), F, T),
    year_clean = str_extract(year_founded, "[:digit:]+"),
    year_clean = as.integer(year_clean),
    year_clean = ifelse(year_positive == TRUE, year_clean, -year_clean)
  )

fake_arch2 |> 
  ggplot(
    aes(x = year_clean, y = year_discovery, colour = site_type)
  ) +
  geom_point() +
  scale_color_brewer(palette = 2, type = "qual") +
  theme(legend.position = "right") +
  labs(x = "Year founded", y = "Year discovered",
       colour = NULL)

fake_arch2 |> 
  ggplot(
    aes(x = year_clean, y = year_discovery)
  ) +
  geom_point() +
  geom_smooth(method = "lm") +
  theme(legend.position = "right") +
  labs(x = "Year founded", y = "Year discovered",
       colour = NULL)

# regression
lm(
  data = fake_arch2,
  year_discovery ~ year_clean
) |> 
  summary()

fake_arch2 |> 
  count(site_type) |> 
  ggplot(aes(y = reorder(site_type,n), x = n)) +
  geom_col() +
  labs(x = "Number of observations",
       y = "Type of site",
       title = "Archaelogical sites",
       subtitle = "Sites in Europe since 2500 BCE")

# prediction

# step 1
# estimate a model
m1 <- glm(formula = y ~ x, family = binomial())

predict(m1, newdata = data.frame(x = c(...)))
