#### DYNAMITE PLOT
# Pitfall 1: No idea of how many observations in each group
# Pitfall 2: No representation of data above mean or misrepresent data below mean
# Pitfall 3: Cannot tell if there is bi-modal or skewed data
# Base layers
m <- ggplot(mtcars, aes(x = cyl, y = wt))

# Draw dynamite plot
m +
  stat_summary(fun.y = mean, geom = "bar", fill = "skyblue") +
  stat_summary(fun.data = mean_sdl, fun.args = list(mult = 1), geom = "errorbar", width = 0.1)


#### DYNAMITE PLOT WITH POSITION
# Base layers
m <- ggplot(mtcars, aes(x = cyl,y = wt, col = factor(am), fill = factor(am)))

# Plot 1: Draw dynamite plot
m +
  stat_summary(fun.y = mean, geom = "bar") +
  stat_summary(fun.data = mean_sdl, fun.args = list(mult = 1), geom = "errorbar", width = 0.1)

# Plot 2: Set position dodge in each stat function
m +
  stat_summary(fun.y = mean, geom = "bar", position = "dodge") +
  stat_summary(fun.data = mean_sdl, fun.args = list(mult = 1), 
               geom = "errorbar", width = 0.1, position = "dodge")

# Set your dodge posn manually
posn.d <- position_dodge(1.5)

# Plot 3: Redraw dynamite plot
m +
  stat_summary(fun.y = mean, geom = "bar", position = posn.d) +
  stat_summary(fun.data = mean_sdl, fun.args = list(mult = 1), geom = "errorbar", width = 0.1, position = posn.d)


#### ALTERNATIVE 1: DYNAMITE PLOT WITH SAMPLE SIZE
# Base layers
library(dplyr)
mtcars.cyl <- mtcars %>% group_by(cyl) %>% summarise(wt.avg = mean(wt), sd = sd(wt), n = n(), prop = n()/nrow(mtcars))
m <- ggplot(mtcars.cyl, aes(x = cyl, y = wt.avg))

# Plot 1: Draw bar plot with geom_bar
m + geom_bar(stat = "identity", fill = "skyblue")

# Plot 2: Draw bar plot with geom_col
m + geom_col(fill = "skyblue")

# Plot 3: geom_col with variable widths.
m + geom_col(fill = "skyblue", width = mtcars.cyl$prop)

# Plot 4: Add error bars
m +
  geom_col(fill = "skyblue", width = mtcars.cyl$prop) +
  geom_errorbar(aes(ymin = wt.avg - sd, ymax = wt.avg + sd), width = 0.1)


#### ALTERNATIVE 2: SCATTERPLOT WITH ERRORBAR
m <- ggplot(mtcars, aes(x = cyl,y = wt)) 
m +
  geom_point(alpha = 0.6, position = position_jitter(width = 0.2)) +
  stat_summary(fun.y = mean, geom = 'point', fill = 'red') +
  stat_summary(fun.data = mean_sdl, mult = 1, geom = 'errorbar', width = 0.2, col = 'red')
