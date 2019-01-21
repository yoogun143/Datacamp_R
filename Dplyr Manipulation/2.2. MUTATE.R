library(hflights)
library(dplyr)

# Add the three variables as described in the third instruction: m2
m2 <- mutate(hflights, 
             TotalTaxi = TaxiIn + TaxiOut, 
             ActualGroundTime = ActualElapsedTime - AirTime, 
             Diff = TotalTaxi - ActualGroundTime)
