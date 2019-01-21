library(openintro)
library(ggplot2)
library(dplyr)


#### SCATTER PLOT
# Mammals scatterplot
ggplot(mammals, aes(BodyWt, BrainWt)) +
  geom_point()

# Scatterplot with coord_trans()
ggplot(data = mammals, aes(x = BodyWt, y = BrainWt)) +
  geom_point() + 
  coord_trans(x = "log10", y = "log10")

# Scatterplot with scale_x_log10() and scale_y_log10()
ggplot(data = mammals, aes(x = BodyWt, y = BrainWt)) +
  geom_point() +
  scale_x_log10() + scale_y_log10()


#### BOXPLOT AS DISCRETIZED SCATTERPLOT
# Boxplot of weight vs. weeks
ggplot(data = ncbirths, 
       aes(x = cut(weeks, breaks = 5), y = weight)) +
  geom_boxplot()


#### OUTLIER
# Original scatter plot
ggplot(mlbBat10, aes(x = OBP, y = SLG)) +
  geom_point()

# Scatterplot of SLG vs. OBP
mlbBat10 %>%
  filter(AB >= 200) %>%
  ggplot(aes(x = OBP, y = SLG)) +
  geom_point()

# Identify the outlying player
mlbBat10 %>%
  filter(AB >= 200, OBP < 0.2)


#### CORRELATION
# Compute correlation
ncbirths %>%
  summarize(N = n(), r = cor(mage, weight))

# Compute correlation for all non-missing pairs
ncbirths %>%
  summarize(N = n(), r = cor(weeks, weight, use = "pairwise.complete.obs"))