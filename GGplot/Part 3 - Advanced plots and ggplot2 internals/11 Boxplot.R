#### TRANSFORMATION FOR HEAVILY SKEWED DATA
# Create movies_small
library(ggplot2)
library(ggplot2movies)
set.seed(123)
movies_small <- movies[sample(nrow(movies), 10000), ]
movies_small$rating <- factor(round(movies_small$rating))

# Add a boxplot geom
d <- ggplot(movies_small, aes(x = rating, y = votes)) +
  geom_point() +
  geom_boxplot() +
  stat_summary(fun.data = "mean_cl_normal",
               geom = "crossbar",
               width = 0.2,
               col = "red")

# Untransformed plot
d

# Transform the scale = Log data points
d + scale_y_log10()

# Transform the coordinates = log result stat, not data point
d + coord_trans(y = "log10")


#### CUT CONTINUOUS VARIABLES UP
# Plot object p
p <- ggplot(diamonds, aes(x = carat, y = price))
p + geom_point(size = 0.01)

# Use cut_interval
# 10 groups with equal range
p + geom_boxplot(aes(group = cut_interval(carat, n = 10)))

# Use cut_number
# 10 groups with equal no of observations
p + geom_boxplot(aes(group = cut_number(carat, n = 10)))

# Use cut_width
# Cut by width
p + geom_boxplot(aes(group = cut_width(carat, width = 0.25)))


#### QUARTILES
# Function to plot 9 ways of calculating quartiles (not important)
plot_quart <- function(n) {
  set.seed(123)
  playData <- data.frame(raw.values = rnorm(n, 1, 6))
  
  quan.summary <- data.frame(t(sapply(1:9, function(x) quantile(playData$raw.values, type = x))))
  names(quan.summary) <- c("Min", "Q1", "Median", "Q3", "Max")
  quan.summary$Type <- as.factor(1:9)
  
  library(reshape2)
  quan.summary <- melt(quan.summary, id = "Type")
  quan.summary <- list(quartiles = quan.summary, values = playData)
  
  ggplot(quan.summary$quartiles, aes(x = Type, y = value, col = variable)) +
    geom_point() +
    geom_rug(data = quan.summary$values, aes(y = raw.values), sides = "l", inherit.aes = F)
}

plot_quart(4)
plot_quart(100)

# =>The IQR becomes more consistent across methods as the sample size increases.


# BOXPLOT WITH VARYING WIDTH
# Finish the plot
ggplot(diamonds, aes(x = cut, y = price, col = color)) +
  geom_boxplot(varwidth = T) +
  facet_grid(. ~ color)