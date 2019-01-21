library(hflights)
library(dplyr)

#  find flights whose equivalent average velocity is lower than the velocity when traveling by car.
hflights %>%
  mutate(RealTime = ActualElapsedTime + 100, 
         mph = Distance / RealTime * 60) %>%
  filter(!is.na(mph), mph < 70) %>%
  summarise(n_less = n(), # No of observations 
            n_dest = n_distinct(Dest), # No of destinations
            min_dist = min(Distance), # Min distance
            max_dist = max(Distance)) # Max distance


# define preferable flights as flights that are at least 50% faster than driving, i.e. that travel 105 mph or greater in real time. Also, assume that cancelled or diverted flights are less preferable than driving.
hflights %>%
  mutate(RealTime = ActualElapsedTime + 100, 
         mph = Distance / RealTime * 60) %>%
  filter(mph < 105 | Cancelled == 1 | Diverted == 1) %>%
  summarise(n_non = n(),
            n_dest = n_distinct(Dest),
            min_dist = min(Distance),
            max_dist = max(Distance))


# How many flights were overnight flights?
hflights %>%
  filter(!is.na(DepTime), 
         !is.na(ArrTime), 
         DepTime > ArrTime) %>%
  summarise(num = n())
