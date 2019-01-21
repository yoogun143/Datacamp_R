library(ggplot2)
# aes() inside geom_()
ggplot(iris, aes(x = Sepal.Length, y = Sepal.Width, col = Species)) +
  geom_point()
ggplot(iris, aes(x = Sepal.Length, y = Sepal.Width)) +
  geom_point(aes(col = Species)) # Same plot results


# Summary statistics = add additional geom
# ADD CENTROID
head(iris)
library(dplyr)
# Something like groupby in Python
iris.summary <- aggregate(iris[1:4], list(iris$Species), mean)
names(iris.summary)[1] <- "Species"
iris.summary
# Add layers
ggplot(iris, aes(x = Sepal.Length, y = Sepal.Width, col = Species)) +
  geom_point() + #Inherits data and aes from ggplot()
  geom_point(data = iris.summary, shape = 21, size = 5, fill = "#00000080") # different data inehrits aes

# ADD CROSSHAIRS
ggplot(iris, aes(x = Sepal.Length, y = Sepal.Width, col = Species)) +
  geom_point() +
  geom_vline(data = iris.summary, linetype = 2,
             aes(xintercept = Sepal.Length, col = Species)) +
  geom_hline(data = iris.summary, linetype = 2,
             aes(yintercept = Sepal.Width, col = Species))


# Jitter: besides define jitter in geom_point(), we can also use geom_jitter()


# Reduce the complexity of scatter plot
ggplot(diamonds, aes(carat, price)) +
  geom_point()
ggplot(diamonds, aes(carat, price)) +
  geom_point(alpha = 0.1)
ggplot(diamonds, aes(carat, price)) +
  geom_point(alpha = 0.01, size = 4)
ggplot(diamonds, aes(carat, price)) +
  geom_point(alpha = 0.3, shape = ".")
