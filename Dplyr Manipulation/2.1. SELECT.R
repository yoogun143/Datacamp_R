library(hflights)
library(dplyr)

# Print out a tbl with the four columns of hflights related to delay
select(hflights, ActualElapsedTime, AirTime, ArrDelay, DepDelay)

# Print out the columns Origin up to Cancelled of hflights
select(hflights, Origin:Cancelled)


#### USE HELPER FUNCTIONS (more on cheatsheet)
# Print out a tbl as described in the second instruction, using both helper functions and variable names
select(hflights, UniqueCarrier, ends_with("Num"), starts_with("Cancell"))


#### COMPARISON TO BASE R
# Finish select call so that ex1d matches ex1r
ex1r <- hflights[c("TaxiIn", "TaxiOut", "Distance")]
ex1d <- select(hflights, TaxiIn, TaxiOut, Distance)
