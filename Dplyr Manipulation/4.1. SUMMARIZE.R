library(hflights)
library(dplyr)


# Print out a summary with variables min_dist and max_dist
summarise(hflights, 
          min_dist = min(Distance), 
          max_dist = max(Distance))

# Print out a summary with variable max_div: the longest distance for diverted flights
summarise(filter(hflights, Diverted == TRUE), 
          max_div = max(Distance))

# Generate summarizing statistics for hflights
summarise(hflights,
          n_obs = nrow(hflights),
          n_carrier = n_distinct(UniqueCarrier),
          n_dest = n_distinct(Dest))