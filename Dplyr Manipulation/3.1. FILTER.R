library(hflights)
library(dplyr)


# All flights that traveled 3000 miles or more
filter(hflights, Distance >= 3000)

# All flights flown by one of AA, BS or CO
filter(hflights, UniqueCarrier %in% c("AA", "BS", "CO"))

# All flights that departed before 5am or arrived after 10pm
filter(hflights, DepTime < 500 | ArrTime > 2200)
