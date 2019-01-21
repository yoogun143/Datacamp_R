#### HIDDEN INDEPENDENCE
setwd("E:/Datacamp/R/Writing Functions")
# Read in the swimming_pools.csv to pools
pools <- read.csv("swimming_pools.csv")

# Examine the structure of pools
str(pools)

# Change the global stringsAsFactor option to FALSE
getOption("stringsAsFactors")
options(stringsAsFactors = FALSE)

# Read in the swimming_pools.csv to pools2
pools2 <- read.csv("swimming_pools.csv")

# Examine the structure of pools2
str(pools2)
# => Name and Address are now characters