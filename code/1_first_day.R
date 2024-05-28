#### first day R script ####

# basics ------------------------------------------------------------------

# assignment to objects
object <- "content"

object <- 132

# printing
1
"some words go here"
object

# there are many functions
x <- c(1,2,3)
x

y <- c("a","b","c")
y

187/32
round(7424/19, digits = 2)

# your first function
add_one <- function(x){
  
  # add 1 to x
  x_plus_one <- x + 1
  
  # returns output to user
  return(x_plus_one)
  
}

# try it
add_one(999)

# multiple inputs
add_and_divide <- function(x, arg_1, arg_2){
  
  # take x, add arg_1 and divide by arg_2
  out <- (x + arg_1) / arg_2
  
  # return
  return(out)
  
}

# try it
add_and_divide(382, 19, 3)

# data types
0.19 # numeric (any real number)
"language and stuff" # character / strings
5L # integer (1,2,3,4)
TRUE | FALSE # logical
NA # special! missing value

# vectorization
# one function call works magically on all elements
nchar(c("a word", "like a dog chasing cars", "string of a different length"))

# packages ----------------------------------------------------------------
# (if you want to make a heading like this press ctrl + shift + R)

# we will be using a set of packages called "tidyverse" to make life easier
# install.packages("tidyverse")
# you might need to restart RStudio
# if the installation isn't working try instead:
# install.packages(c("dplyr","ggplot2","stringr","tidyr"))

# install once
# call library() in each session

# data frames intro -------------------------------------------------------

# variables and observations

# read spreadsheet

# pipes

# filtering

# strings -----------------------------------------------------------------

# sometimes you can get data from an R package
# install.packages("janeaustenr")
# 6 complete published novels

six_books <- janeaustenr::austen_books()

six_books |> 
  dplyr::filter(text != "") |> 
  dplyr::count(book)

# reading pdfs ------------------------------------------------------------

# pdftools package

# more data frames --------------------------------------------------------

# changing / creating variables

# if statements

# long to wide

# plotting ----------------------------------------------------------------


