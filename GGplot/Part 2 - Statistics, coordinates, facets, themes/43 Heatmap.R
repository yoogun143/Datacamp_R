# HEATMAP
# Pitfall 1: Color on a continuous scale is hard to interpret
# Pitfall 2: Perception changes based on neighboring colors
# Create color palette
myColors <- brewer.pal(9, "Reds")

# Build the heat map from scratch
ggplot(barley, aes(x = year, y = variety, fill = yield)) +
  geom_tile() + # Geom layer
  facet_wrap( ~ site, ncol = 1) + # Facet layer
  scale_fill_gradientn(colors = myColors) # Adjust colors


#### ALTERNATIVE 1: SCATTERPLOT
ggplot(barley, aes(x = yield, y = variety, col = year)) +
  geom_point(pch = 1, size = 2) +
  facet_wrap( ~ site, ncol = 1)


#### ALTERNATIVE 2: LINEPLOT
# Line plot; set the aes, geom and facet
ggplot(barley, aes(x = year, y = yield, color = variety, group = variety)) + 
  geom_line() +
  facet_wrap( ~ site, nrow = 1)


#### DEPICT OVERLAPPING MEASUREMENTS OF SPREAD: OVERLLAPING TRANSPARENT RIBBON
# Create overlapping ribbon plot from scratch
ggplot(barley, aes(x = year, y = yield, col = site, group = site, fill = site)) +
  stat_summary(fun.y = mean, geom = "line") +
  stat_summary(fun.data = mean_sdl, fun.args = list(mult = 1), geom = "ribbon", alpha = 0.1, col = NA)


#### DEPICT OVERLAPPING MEASUREMENTS OF SPREAD: DODGED ERROR BARS
ggplot(barley, aes(x = year, y = yield, col = site, group = site, fill = site)) +
  stat_summary(fun.y = mean, geom = "line") +
  stat_summary(fun.data = mean_sdl, fun.args = list(mult = 1), geom = "errorbar", width = 0.1) +
  coord_fixed(ratio = 0.01)
