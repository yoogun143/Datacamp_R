#### STACKED BAR PLOT
# Explore africa
setwd("E:/Datacamp/R/GGplot/Part 3 - Advanced plots and ggplot2 internals")
load('africa.RData')
africa_sample = africa[1:50,]
str(africa)
str(africa_sample)

# Add an ID column from the row.names
africa_sample$ID <- row.names(africa_sample)

# Gather africa_sample
library(tidyr)
africa_sample_tidy <- gather(africa_sample, key, value, -ID)
head(africa_sample_tidy)

# Finish the ggplot command
library(ggplot2)
ggplot(africa_sample_tidy, aes(x = factor(ID), y = value, fill = key)) +
  geom_col() +
  coord_flip()


#### TERNARY PLOT
# Load ggtern
library(ggtern)

# Build ternary plot
ggtern(africa, aes(x = Sand, y = Silt, z = Clay)) +
  geom_point(shape = 16, alpha = 0.2)

# Plot 1
ggtern(africa, aes(x = Sand, y = Silt, z = Clay)) +
  geom_density_tern()

# Plot 2
ggtern(africa, aes(x = Sand, y = Silt, z = Clay)) +
  stat_density_tern(geom = 'polygon', aes(fill = ..level.., alpha = ..level..)) +
  guides(fill = FALSE)
