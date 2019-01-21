# PIE CHART 
# one categorical variable (am) as a proportion of another (cyl)
# Bar chart
ggplot(mtcars, aes(x = cyl, fill = factor(am))) +
  geom_bar(position = "fill")

# Convert bar chart to pie chart
ggplot(mtcars, aes(x = factor(1), fill = factor(am))) +
  geom_bar(position = "fill", width = 1) +
  facet_grid(. ~ cyl) + 
  coord_polar(theta = "y") +
  theme_void()

#### ALTERNATIVE 1: HORIZONTAL BARCHART
ggplot(mtcars, aes(x = cyl, fill = factor(am))) +
  geom_bar(position = "fill", width = 1) +
  coord_flip()

#### ALTERNATIVE 2: PARALELL PLOT
# Two or more categorical variables, independent of each other
# Individual observations are connected with lines, colored according to a variable of interest
library(gridExtra)
a <- ggplot(mtcars, aes(x = factor(1), fill = factor(cyl))) +
  geom_bar(width = 1) +
  coord_polar(theta = 'y') +
  ggtitle('Cylinders') +
  theme(legend.position = "bottom",
        legend.title = element_blank())
b <- ggplot(mtcars, aes(x = factor(1), fill = factor(am))) +
  geom_bar(width = 1) +
  coord_polar(theta = 'y') +
  ggtitle('Transmission') +
  theme(legend.position = "bottom",
        legend.title = element_blank())
c <- ggplot(mtcars, aes(x = factor(1), fill = factor(gear))) +
  geom_bar(width = 1) +
  coord_polar(theta = 'y') +
  ggtitle('Gears') +
  theme(legend.position = "bottom",
        legend.title = element_blank())
d <- ggplot(mtcars, aes(x = factor(1), fill = factor(carb))) +
  geom_bar(width = 1) +
  coord_polar(theta = 'y') +
  ggtitle('Carburetor') +
  theme(legend.position = "bottom",
        legend.title = element_blank())
grid.arrange(a, b, c, d, ncol = 2)
# => This many pie charts is an unsatisfactory visualization because We're interested in the relationship between all these variables (e.g. where are 8 cylinder cars represented on the Transmission, Gear and Carburetor variables?)

# Parallel coordinates plot using GGally
library(GGally)

# All columns except am
group_by_am <- 9
my_names_am <- (1:11)[-group_by_am]

# Basic parallel plot - each variable plotted as a z-score transformation
ggparcoord(mtcars, my_names_am, groupColumn = group_by_am, alpha = 0.8)


#### PLOT MATRIX
ggpairs(mtcars)
