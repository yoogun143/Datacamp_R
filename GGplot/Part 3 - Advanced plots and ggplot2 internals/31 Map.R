library(maps)
library(ggplot2)
library(ggmap)
library(ggthemes)
library(viridis)
setwd("E:/Datacamp/R/GGplot/Part 3 - Advanced plots and ggplot2 internals")
cities <- read.delim("E:/Datacamp/R/GGplot/Part 3 - Advanced plots and ggplot2 internals/US_Cities.txt")


#### MAP
# Use map_data() to create usa
usa <- map_data("usa")
str(usa)

# Build the map
ggplot(usa, aes(x = long, y = lat, group = group)) +
  geom_polygon() +
  coord_map() +
  theme_nothing()

# Finish plot 1
ggplot(usa, aes(x = long, y = lat, group = group)) +
  geom_polygon() +
  geom_point(data = cities, aes(group = State, size = Pop_est),
             col = "red", shape = 16, alpha = 0.6) +
  coord_map() +
  theme_map()

# Arrange cities
library(dplyr)
cities_arr <- arrange(cities, Pop_est)

# Copy-paste plot 1 and adapt
ggplot(usa, aes(x = long, y = lat, group = group)) +
  geom_polygon(fill = "grey90") +
  geom_point(data = cities_arr, aes(group = State, col = Pop_est), size = 2, shape = 16, alpha = 0.6) +
  coord_map() +
  theme_map() +
  scale_color_viridis()


#### CHOROPLETH
# Use map_data() to create state
state <- map_data("state")

# Map of states
ggplot(state, aes(x = long, y = lat, fill = region, group = group)) +
  geom_polygon(col = "white") +
  coord_map() +
  theme_nothing()

# Merge state and pop: state2
pop <- dget('pop.txt')
state2 <- merge(state, pop)

# Map of states with populations
ggplot(state2, aes(x = long, y = lat, fill = Pop_est, group = group)) +
  geom_polygon(col = "white") +
  coord_map() +
  theme_map()


#### CHOROPLETH FROM SHAPE FILE
# Import shape information: germany (in shapes folder)
library(rgdal)
dir()
germany <- readOGR(dsn = "shapes", layer = "DEU_adm1")

# fortify germany: bundes
bundes <- fortify(germany)

# Plot map of germany
ggplot(bundes, aes(x = long, y = lat, group = group)) +
  geom_polygon(fill = "blue", col = "white") +
  coord_map() +
  theme_nothing()

# re-add state names to bundes
bundes$state <- factor(as.numeric(bundes$id))
levels(bundes$state) <- germany$NAME_1

# Merge bundes and unemp: bundes_unemp
unemp = read.csv('germany_unemployment.txt', sep = '\t')
bundes_unemp <- merge(bundes, unemp)

# Update the ggplot call
ggplot(bundes_unemp, aes(x = long, y = lat, group = group, fill = unemployment)) +
  geom_polygon() +
  coord_map() +
  theme_map()


#### CARTOGRAPHIC MAP
# Load the ggmap package
library(ggmap)

# Experiment with get_map() and use ggmap() to plot it!
hanoi_map <- get_map("Hanoi, Vietnam", maptype = "toner", zoom = 13)
ggmap(hanoi_map)

hanoi_sites = c('Van Mieu', 'Ho Guom')
# Use geocode() to create xx
xx <- geocode(hanoi_sites)

# Add a location column to xx
xx$location <- sub(", Hanoi", "", hanoi_sites)

# Add a geom_points layer
ggmap(hanoi_map) + geom_point(data = xx, aes(x = lon, y = lat, col = location), size = 6)


#### CARTOGRAPHIC & CHOROPLETH
# Get the map data of "Germany"
germany_06 <- get_map(location = "Germany", zoom = 6)

# Plot map and polygon on top:
ggmap(germany_06) +
  geom_polygon(data = bundes,
               aes(x = long, y = lat, group = group),
               fill = NA, col = "red") +
  coord_map()