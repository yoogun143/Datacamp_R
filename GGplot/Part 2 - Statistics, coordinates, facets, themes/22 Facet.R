# Basic scatter plot
p <- ggplot(mtcars, aes(x = wt, y = mpg)) +
  geom_point()

# 1 - Separate rows according to transmission type, am
p +
  facet_grid(am ~ .)

# 2 - Separate columns according to cylinders, cyl
p +
  facet_grid(. ~ cyl)

# 3 - Separate by both columns and rows 
p +
  facet_grid(am ~ cyl)


#### MANY VARIABLES
# Code to create the cyl_am col and myCol vector
mtcars$cyl_am <- paste(mtcars$cyl, mtcars$am, sep = "_")
myCol <- rbind(brewer.pal(9, "Blues")[c(3,6,8)],
               brewer.pal(9, "Reds")[c(3,6,8)])

# Map cyl_am onto col
ggplot(mtcars, aes(x = wt, y = mpg, col = cyl_am)) +
  geom_point() +
  # Add a manual colour scale
  scale_color_manual(values = myCol)

# Grid facet on gear vs. vs
ggplot(mtcars, aes(x = wt, y = mpg, col = cyl_am)) +
  geom_point() +
  scale_color_manual(values = myCol) +
  facet_grid(gear ~ vs)

# Also map disp to size
ggplot(mtcars, aes(x = wt, y = mpg, col = cyl_am, size = disp)) +
  geom_point() +
  scale_color_manual(values = myCol) +
  facet_grid(gear ~ vs)


#### DROP LEVEL
# When you have a categorical variable with many levels which are not all present in each sub-group of another variable, it may be desirable to drop the unused levels.
# Basic scatter plot
p <- ggplot(msleep, aes(x = sleep_total, y = name, col = genus)) +
  geom_point()

# Execute to display plot
p

# Facet rows accoding to vore
p +
  facet_grid(vore ~ .)

# Specify scale and space arguments to free up rows
p +
  facet_grid(vore ~ ., scale = "free_y", space = "free_y")

