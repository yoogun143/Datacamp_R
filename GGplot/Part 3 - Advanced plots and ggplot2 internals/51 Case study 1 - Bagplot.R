setwd("E:/Datacamp/R/GGplot/Part 3 - Advanced plots and ggplot2 internals")
load('test_datasets.RData')
library(aplpack)
library(ggplot2)

#### BASE PACKAGE BAG PLOT
# Call bagplot() on test_data
test_data = ch5_test_data
bagplot(test_data)

# Call compute.bagplot on test_data, assign to bag
bag <- compute.bagplot(test_data)

# Display information
bag$hull.loop
bag$hull.bag
bag$pxy.outlier

# Highlight components
points(bag$hull.loop, col = "green", pch = 16)
points(bag$hull.bag, col = "orange", pch = 16)
points(bag$pxy.outlier, col = "purple", pch = 16)


#### MULTILAYER GGPLOT2 BAGPLOT
# Create data frames from matrices
hull.loop <- data.frame(x = bag$hull.loop[,1], y = bag$hull.loop[,2])
hull.bag <- data.frame(x = bag$hull.bag[,1], y = bag$hull.bag[,2])
pxy.outlier <- data.frame(x = bag$pxy.outlier[,1], y = bag$pxy.outlier[,2])

# Finish the ggplot command
ggplot(test_data, aes(x = x,  y = y)) +
  geom_polygon(data = hull.loop, fill = "green") +
  geom_polygon(data = hull.bag, fill = "orange") +
  geom_point(data = pxy.outlier, col = "purple", pch = 16, cex = 1.5)


#### GGPROTO FUNCTION = CREATE GGPLOT LAYER
# ggproto for StatLoop (hull.loop)
StatLoop <- ggproto("StatLoop", Stat,
                    required_aes = c("x", "y"),
                    compute_group = function(data, scales) {
                      bag <- compute.bagplot(x = data$x, y = data$y)
                      data.frame(x = bag$hull.loop[,1], y = bag$hull.loop[,2])
                    })

# ggproto for StatBag (hull.bag)
StatBag <- ggproto("StatBag", Stat,
                   required_aes = c("x", "y"),
                   compute_group = function(data, scales) {
                     bag <- compute.bagplot(x = data$x, y = data$y)
                     data.frame(x = bag$hull.bag[,1], y = bag$hull.bag[,2])
                   })

# ggproto for StatOut (pxy.outlier)
StatOut <- ggproto("StatOut", Stat,
                   required_aes = c("x", "y"),
                   compute_group = function(data, scales) {
                     bag <- compute.bagplot(x = data$x, y = data$y)
                     data.frame(x = bag$pxy.outlier[,1], y = bag$pxy.outlier[,2])
                   })

# Combine ggproto objects in layers to build stat_bag()
stat_bag <- function(mapping = NULL, data = NULL, geom = "polygon",
                     position = "identity", na.rm = FALSE, show.legend = NA,
                     inherit.aes = TRUE, loop = FALSE, ...) {
  list(
    # StatLoop layer
    layer(
      stat = StatLoop, data = data, mapping = mapping, geom = geom, 
      position = position, show.legend = show.legend, inherit.aes = inherit.aes,
      params = list(na.rm = na.rm, alpha = 0.35, col = NA, ...)
    ),
    # StatBag layer
    layer(
      stat = StatBag, data = data, mapping = mapping, geom = geom, 
      position = position, show.legend = show.legend, inherit.aes = inherit.aes,
      params = list(na.rm = na.rm, alpha = 0.35, col = NA, ...)
    ),
    # StatOut layer
    layer(
      stat = StatOut, data = data, mapping = mapping, geom = "point", 
      position = position, show.legend = show.legend, inherit.aes = inherit.aes,
      params = list(na.rm = na.rm, alpha = 0.7, col = NA, shape = 21, ...)
    )
  )
}

# stat_bag
ggplot(test_data, aes(x = x, y = y)) +
  stat_bag(fill = 'black')

# stat_bag on test_data2
test_data2 <- ch5_test_data2
ggplot(test_data2, aes(x = x, y = y, fill = treatment)) +
  stat_bag()
