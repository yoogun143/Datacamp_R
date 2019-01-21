#### Overplotting 1 - Data points are imprecise, not clearly separated
# Basic scatter plot: wt on x-axis and mpg on y-axis; map cyl to col
ggplot(mtcars, aes(x = wt, y = mpg, col = cyl)) +
  geom_point(size = 4)

# Hollow circles - an improvement
ggplot(mtcars, aes(x = wt, y = mpg, col = cyl)) +
  geom_point(size = 4, shape = 1)

# Add transparency - very nice
ggplot(mtcars, aes(x = wt, y = mpg, col = cyl)) +
  geom_point(size = 4, alpha = 0.6)


#### Overplotting 2 - Aligned data values on a single axis
# Scatter plot: carat (x), price (y), clarity (color)
ggplot(diamonds, aes(x = carat, y = price, col = clarity)) +
  geom_point()

# Adjust for overplotting
ggplot(diamonds, aes(x = carat, y = price, col = clarity)) +
  geom_point(alpha = 0.5)

# Scatter plot: clarity (x), carat (y), price (color)
ggplot(diamonds, aes(x = clarity, y = carat, col = price)) +
  geom_point(alpha = 0.5)

# Dot plot with jittering
ggplot(diamonds, aes(x = clarity, y = carat, col = price)) +
  geom_point(alpha = 0.5, position = "jitter")


#### CONTINUOUS VARIABLES:
# Most efficiency: position on a common scale
# Least effcient: Color spectrum

#### CATEGORICAL VARIABLES
# Most efficient: Qualitative colors, labels, line colors
# Lease efficient: filled shape, hatching, line width