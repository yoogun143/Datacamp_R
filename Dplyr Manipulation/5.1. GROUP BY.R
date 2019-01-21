library(hflights)
library(dplyr)


# Make an ordered per-carrier summary of hflights
hflights %>%
  group_by(UniqueCarrier) %>%
  summarise(p_canc = mean(Cancelled) * 100,
            avg_delay = mean(ArrDelay, na.rm = TRUE)) %>%
  arrange(avg_delay, p_canc)


# Ordered overview of average arrival delays per carrier
hflights %>%
  filter(!is.na(ArrDelay), ArrDelay > 0) %>%
  group_by(UniqueCarrier) %>%
  summarise(avg = mean(ArrDelay)) %>%
  mutate(rank = rank(avg)) %>%
  arrange(rank)

# How many airplanes only flew to one destination?
hflights %>%
  group_by(TailNum) %>%
  summarise(ndest = n_distinct(Dest)) %>%
  filter(ndest == 1) %>%
  summarise(nplanes = n())

# Find the most visited destination for each carrier
hflights %>% 
  group_by(UniqueCarrier, Dest) %>%
  summarise(n = n()) %>%
  mutate(rank = rank(desc(n))) %>%
  filter(rank == 1)
