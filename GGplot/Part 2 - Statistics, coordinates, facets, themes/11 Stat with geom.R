library(ggplot2)


#### SMOOTHING
# Explore the mtcars data frame with str()
str(mtcars)

# A scatter plot with LOESS smooth:
ggplot(mtcars, aes(x = wt, y = mpg)) +
  geom_point() +
  geom_smooth()

# A scatter plot with an ordinary Least Squares linear model:
ggplot(mtcars, aes(x = wt, y = mpg)) +
  geom_point() +
  geom_smooth(method = "lm")

# The previous plot, without CI ribbon:
ggplot(mtcars, aes(x = wt, y = mpg)) +
  geom_point() +
  geom_smooth(method = "lm", se = FALSE)

# The previous plot, without points:
ggplot(mtcars, aes(x = wt, y = mpg)) +
  geom_smooth(method = "lm", se = FALSE)


#### GROUP VARIABLES
# Define cyl as a factor variable
ggplot(mtcars, aes(x = wt, y = mpg, col = factor(cyl))) +
  geom_point() +
  stat_smooth(method = "lm", se = F)

# Complete the following ggplot command as instructed
ggplot(mtcars, aes(x = wt, y = mpg, col = factor(cyl))) +
  geom_point() +
  stat_smooth(method = "lm", se = F) +
  stat_smooth(method = "lm", se = F, aes(group = 1))


#### MODIFY STAT_SMOOTH (1)
# Plot 1: change the LOESS span
ggplot(mtcars, aes(x = wt, y = mpg)) +
  geom_point() +
  # Add span below
  geom_smooth(se = F, span = 0.7)

# Plot 2: Set the overall model to LOESS and use a span of 0.7
ggplot(mtcars, aes(x = wt, y = mpg, col = factor(cyl))) +
  geom_point() +
  stat_smooth(method = "lm", se = F) +
  # Change method and add span below
  stat_smooth(method = "loess", aes(group = 1),
              se = F, col = "black", span = 0.7)

# Plot 3: Set col to "All", inside the aes layer of stat_smooth()
ggplot(mtcars, aes(x = wt, y = mpg, col = factor(cyl))) +
  geom_point() +
  stat_smooth(method = "lm", se = F) +
  stat_smooth(method = "loess",
              # Add col inside aes()
              aes(group = 1, col = "All"),
              # Remove the col argument below
              se = F, span = 0.7)

# Plot 4: Add scale_color_manual to change the colors
library(RColorBrewer)
myColors <- c(brewer.pal(3, "Dark2"), "black")
ggplot(mtcars, aes(x = wt, y = mpg, col = factor(cyl))) +
  geom_point() +
  stat_smooth(method = "lm", se = F, span = 0.75) +
  stat_smooth(method = "loess",
              aes(group = 1, col="All"),
              se = F, span = 0.7) +
  # Add correct arguments to scale_color_manual
  scale_color_manual("Cylinders", values = myColors)


#### MODIFY STAT_SMOOTH (2)
Vocab <- read.csv("E:/Datacamp/R/GGplot/Part 2 - Statistics, coordinates, facets, themes/GSSvocab.csv")
# Plot 1: Jittered scatter plot, add a linear model (lm) smooth:
ggplot(Vocab, aes(x = educ, y = vocab)) +
  geom_jitter(alpha = 0.2) +
  stat_smooth(method = "lm", se = FALSE)

# Plot 2: Only lm, colored by year
ggplot(Vocab, aes(x = educ, y = vocab, col = factor(year))) +
  stat_smooth(method = "lm", se = FALSE)

# Plot 3: Set a color brewer palette
ggplot(Vocab, aes(x = educ, y = vocab, col = factor(year))) +
  stat_smooth(method = "lm", se = FALSE) +
  scale_color_brewer()

# Plot 4: Add the group, specify alpha and size
ggplot(Vocab, aes(x = educ, y = vocab, col = year, group = factor(year))) + # need group aes because year is integer while we want continuous scale
  stat_smooth(method = "lm", se = F, alpha = 0.6, size = 2) +
  scale_color_gradientn(colors = brewer.pal(9,"YlOrRd"))


#### QUANTILES REGRESSION
# By default, the 1st, 2nd (i.e. median), and 3rd quartiles are modeled as a response to the predictor variable, in this case education
# Use stat_quantile instead of stat_smooth:
ggplot(Vocab, aes(x = educ, y = vocab, col = year, group = factor(year))) +
  stat_quantile(alpha = 0.6, size = 2) +
  scale_color_gradientn(colors = brewer.pal(9,"YlOrRd"))

# Set quantile to 0.5: => on;y median is shown
ggplot(Vocab, aes(x = educ, y = vocab, col = year, group = factor(year))) +
  stat_quantile(alpha = 0.6, size = 2, quantiles = 0.5) +
  scale_color_gradientn(colors = brewer.pal(9,"YlOrRd"))


#### SUM
# calculates the total number of overlapping observations and is another good alternative to overplotting.
# Plot 1: Jittering only
p <- ggplot(Vocab, aes(x = educ, y = vocab)) +
  geom_jitter(alpha = 0.2)

# Plot 2: Add stat_sum
p +
  stat_sum() # sum statistic

# Plot 3: Set size range
p +
  stat_sum() + # sum statistic
  scale_size(range = c(1, 10)) # set size scale
