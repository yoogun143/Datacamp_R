# Load the insuranceData package
library(insuranceData)

# Use the data() function to load the dataCar data frame
data(dataCar)

# Load the tabplot package
suppressPackageStartupMessages(library(tabplot))

# Generate the default tableplot() display
tableplot(dataCar)
