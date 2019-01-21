# ZOOM IN
# Basic ggplot() command, coded for you
p <- ggplot(mtcars, aes(x = wt, y = hp, col = am)) + geom_point() + geom_smooth()

# Add scale_x_continuous (remove unseen data points = clipping)
p + scale_x_continuous(limits = c(3,6), expand = c(0,0))

# The proper way to zoom in: (without clipping)
p + coord_cartesian(xlim = c(3,6))


#### ASPECT RATIO
# Complete basic scatter plot function
base.plot <- ggplot(iris, aes(x = Sepal.Length, y = Sepal.Width, col = Species)) +
  geom_jitter() +
  geom_smooth(method = "lm", se = F)

# Plot base.plot: default aspect ratio
base.plot

# Fix aspect ratio (1:1) of base.plot
base.plot + coord_equal()

# Another way:
base.plot + coord_fixed()


#### PIE CHART
# Create a stacked bar plot: wide.bar
wide.bar <- ggplot(mtcars, aes(x = 1, fill = factor(cyl))) +
  geom_bar()

# Convert wide.bar to pie chart
wide.bar +
  coord_polar(theta = "y")

# Create stacked bar plot: thin.bar
thin.bar <- ggplot(mtcars, aes(x = 1, fill = factor(cyl))) +
  geom_bar(width = .1) +
  scale_x_continuous(limits = c(0.5,1.5))

# Convert thin.bar to "ring" type pie chart
thin.bar +
  coord_polar(theta = "y")
