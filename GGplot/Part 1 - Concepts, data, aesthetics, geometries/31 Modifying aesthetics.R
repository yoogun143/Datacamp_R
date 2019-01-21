#### AESTHETICS
# am and cyl are factors, wt is numeric
class(mtcars$am)
class(mtcars$cyl)
class(mtcars$wt)

# From the previous exercise
ggplot(mtcars, aes(x = wt, y = mpg, col = cyl)) +
  geom_point(shape = 1, size = 4)

# Map cyl to fill (not work)
ggplot(mtcars, aes(x = wt, y = mpg, fill = cyl)) +
  geom_point(shape = 1, size = 4)

# Change shape and alpha of the points in the above plot
ggplot(mtcars, aes(x = wt, y = mpg, fill = cyl)) +
  geom_point(shape = 21, size = 4, alpha = 0.6)

# Map am to col in the above plot
ggplot(mtcars, aes(x = wt, y = mpg, col = am)) +
  geom_point(shape = 21, size = 4, alpha = 0.6)

# Combine above 2 plots
ggplot(mtcars, aes(x = wt, y = mpg, fill = cyl, col = am)) +
  geom_point(shape = 21, size = 4, alpha = 0.6)

# Map cyl to size
ggplot(mtcars, aes(x = wt, y = mpg, size = cyl)) +
  geom_point()

# Map cyl to alpha
ggplot(mtcars, aes(x = wt, y = mpg, alpha = cyl)) +
  geom_point()

# Map cyl to shape (only to categorical data)
ggplot(mtcars, aes(x = wt, y = mpg, shape = cyl)) +
  geom_point()

# Map cyl to label (only to categorical data)
ggplot(mtcars, aes(x = wt, y = mpg, label = cyl)) +
  geom_text()


#### ATTRIBUTES
# Define a hexadecimal color
my_color <- "#4ABEFF"

# First scatter plot, with col aesthetic:
ggplot(mtcars, aes(x = wt, y = mpg, col = cyl)) +
  geom_point()

# Plot with color attribute => overwrite cyl color
ggplot(mtcars, aes(x = wt, y = mpg, col = cyl)) +
  geom_point(col = my_color)

# Add many mappings => decrease readability
ggplot(mtcars, aes(x = mpg, y = qsec, col = factor(cyl), shape = factor(am), size = (hp/wt))) +
  geom_point()
