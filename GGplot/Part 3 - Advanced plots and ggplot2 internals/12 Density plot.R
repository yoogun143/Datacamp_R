setwd("E:/Datacamp/R/GGplot/Part 3 - Advanced plots and ggplot2 internals")
load('test_datasets.RData')
library(ggplot2)

# Calculating density: d
d <- density(ch1_test_data$norm)

# Use which.max() to calculate mode
mode <- d$x[which.max(d$y)]

# Finish the ggplot call
ggplot(ch1_test_data, aes(x = norm)) +
  geom_rug() +
  geom_density() +
  geom_vline(xintercept = mode, col = "red")


#### COMBINE DENSITY PLOT AND HISTOGRAM
# Arguments you'll need later on
fun_args <- list(mean = mean(ch1_test_data$norm), sd = sd(ch1_test_data$norm))

# Finish the ggplot
ggplot(ch1_test_data, aes(x = norm)) +
  geom_histogram(aes(y = ..density..)) +
  geom_density(col = "red") + #Empirical PDF = real
  stat_function(fun = dnorm, args = fun_args, col = "blue") #Theoretical PDF with mean and sd of dataset


#### ADJUST DENSITY PLOT
small_data = data.frame(x = c(-3.5, 0, 0.5, 6))

# Get the bandwith
get_bw <- density(small_data$x)$bw

# Basic plotting object
p <- ggplot(small_data, aes(x = x)) +
  geom_rug() +
  coord_cartesian(ylim = c(0,0.5))

# Create three plots
p + geom_density()
p + geom_density(adjust = 0.25)
p + geom_density(bw = 0.25 * get_bw)

# Create two plots
p + geom_density(kernel = "r")
p + geom_density(kernel = "e")


#### MULTIPLE DENSITY PLOT
setwd("E:/Datacamp/R/GGplot/Part 3 - Advanced plots and ggplot2 internals")
mammals <- readRDS('mammals.RDS')
# Individual densities
ggplot(mammals[mammals$vore == "Insectivore",], aes(x = sleep_total, fill = vore)) +
  geom_density(col = NA, alpha = 0.35) +
  scale_x_continuous(limits = c(0, 24)) +
  coord_cartesian(ylim = c(0, 0.3))

# With faceting
ggplot(mammals, aes(x = sleep_total, fill = vore)) +
  geom_density(col = NA, alpha = 0.35) +
  scale_x_continuous(limits = c(0, 24)) +
  coord_cartesian(ylim = c(0, 0.3)) +
  facet_wrap( ~ vore, nrow = 2)

# By default, the x ranges fill the scale
ggplot(mammals, aes(x = sleep_total, fill = vore)) +
  geom_density(col = NA, alpha = 0.35) +
  scale_x_continuous(limits = c(0, 24)) +
  coord_cartesian(ylim = c(0, 0.3))

# Trim each density plot individually
# Since the distributions are cut off at the extreme ends, the area under the curve technically is not equal to one anymore.
ggplot(mammals, aes(x = sleep_total, fill = vore)) +
  geom_density(col = NA, alpha = 0.35, trim = TRUE) +
  scale_x_continuous(limits = c(0, 24)) +
  coord_cartesian(ylim = c(0, 0.3))


#### WEIGHTED DENSITY PLOT
# Unweighted density plot from before
ggplot(mammals, aes(x = sleep_total, fill = vore)) +
  geom_density(col = NA, alpha = 0.35) +
  scale_x_continuous(limits = c(0, 24)) +
  coord_cartesian(ylim = c(0, 0.3))

# Unweighted violin plot
ggplot(mammals, aes(x = vore, y = sleep_total, fill = vore)) +
  geom_violin()

# Calculate weighting measure
library(dplyr)
mammals2 <- mammals %>%
  group_by(vore) %>%
  mutate(n = n() / nrow(mammals)) -> mammals

# Weighted density plot
ggplot(mammals2, aes(x = sleep_total, fill = vore)) +
  geom_density(aes(weight = n), col = NA, alpha = 0.35) +
  scale_x_continuous(limits = c(0, 24)) +
  coord_cartesian(ylim = c(0, 0.3))

# Weighted violin plot
ggplot(mammals2, aes(x = vore, y = sleep_total, fill = vore)) +
  geom_violin(aes(weight = n), col = NA)


#### 2D DENSITY PLOT - BASE
# Base layers
p <- ggplot(faithful, aes(x = waiting, y = eruptions)) +
  scale_y_continuous(limits = c(1, 5.5), expand = c(0, 0)) +
  scale_x_continuous(limits = c(40, 100), expand = c(0, 0)) +
  coord_fixed(60 / 4.5)

# 1 - Use geom_density_2d()
p + geom_density_2d()

# 2 - Use stat_density_2d() with arguments
p + stat_density_2d(aes(col = ..level..) # Change line color according to density level
                    , h = c(5, 0.5)) # bandwith of x axis is 5 and y axis if 0.5


#### 2D DENSITY PLOT - PACKAGE
# Load in the viridis package
library(viridis)

# Add viridis color scale
ggplot(faithful, aes(x = waiting, y = eruptions)) +
  scale_y_continuous(limits = c(1, 5.5), expand = c(0,0)) +
  scale_x_continuous(limits = c(40, 100), expand = c(0,0)) +
  coord_fixed(60/4.5) +
  stat_density_2d(geom = "tile", aes(fill = ..density..), h=c(5,.5), contour = FALSE) +
  scale_fill_viridis()
