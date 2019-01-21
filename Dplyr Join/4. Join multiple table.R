# Load the purrr library
library(purrr)
library(dplyr)
library(readr)
complete1 <- read_csv("E:/Datacamp/R/Dplyr Join/complete.csv")
complete2 <- read_csv("E:/Datacamp/R/Dplyr Join/complete.csv")
complete3 <- read_csv("E:/Datacamp/R/Dplyr Join/complete.csv")

# Place supergroups, more_bands, and more_artists into a list
list(complete1, complete2, complete3) %>% 
  # Use reduce to join together the contents of the list
  reduce(left_join)