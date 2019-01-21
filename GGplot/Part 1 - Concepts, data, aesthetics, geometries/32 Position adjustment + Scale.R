#### BARPLOT
# The base layer, cyl.am, is available for you
cyl.am <- ggplot(mtcars, aes(x = factor(cyl), fill = factor(am)))
# Add geom (position = "stack" by default)
cyl.am + 
  geom_bar()

# Fill - show proportion
cyl.am + 
  geom_bar(position = "fill")  

# Dodging - principles of similarity and proximity
cyl.am +
  geom_bar(position = "dodge") 

# Parameter for dodge
cyl.am +
  geom_bar(position = position_dodge(0.7))

# Clean up the axes with scale_ functions (Legend)
val = c("#E41A1C", "#377EB8")
lab = c("Manual", "Automatic")
cyl.am +
  geom_bar(position = "dodge") +
  scale_x_discrete("Cylinders") + 
  scale_y_continuous('Number') +
  scale_fill_manual("Transmission", 
                    values = val,
                    labels = lab) 


#### SCATTERPLOT
# Position identity (default)
ggplot(iris, aes(x = Sepal.Length, y = Sepal.Width, col = Species)) +
  geom_point()

# Equal to
ggplot(iris, aes(x = Sepal.Length, y = Sepal.Width, col = Species)) +
  geom_point(position = 'identity')

# Position jitter
ggplot(iris, aes(x = Sepal.Length, y = Sepal.Width, col = Species)) +
  geom_point(position = 'jitter')

# Parameter for jitter
posn.j <- position_jitter(width = 0.1)
ggplot(iris, aes(x = Sepal.Length, y = Sepal.Width, col = Species)) +
  geom_point(position = posn.j)


#### SCALE
# Scale_
ggplot(iris, aes(x = Sepal.Length, y = Sepal.Width, col = Species)) +
  geom_point(position = "jitter") +
  scale_x_continuous("Sepal Length") +
  scale_color_discrete("Species")

# Limit
ggplot(iris, aes(x = Sepal.Length, y = Sepal.Width, col = Species)) +
  geom_point(position = "jitter") +
  scale_x_continuous("Sepal Length", limits = c(2, 8)) +
  scale_color_discrete("Species")

# Breaks
ggplot(iris, aes(x = Sepal.Length, y = Sepal.Width, col = Species)) +
  geom_point(position = "jitter") +
  scale_x_continuous("Sepal Length", limits = c(2, 8), 
                     breaks = seq(2, 8, 3)) +
  scale_color_discrete("Species")

# Expand
ggplot(iris, aes(x = Sepal.Length, y = Sepal.Width, col = Species)) +
  geom_point(position = "jitter") +
  scale_x_continuous("Sepal Length", limits = c(2, 8), 
                     breaks = seq(2, 8, 3), expand = c(0, 0)) +
  scale_color_discrete("Species")

# Label
ggplot(iris, aes(x = Sepal.Length, y = Sepal.Width, col = Species)) +
  geom_point(position = "jitter") +
  scale_x_continuous("Sepal Length", limits = c(2, 8), 
                     breaks = seq(2, 8, 3), expand = c(0, 0)) +
  scale_color_discrete("Species",
                       labels = c('Setosa', "Versicolour", 'Virginica'))

# Lab = Other method for label
ggplot(iris, aes(x = Sepal.Length, y = Sepal.Width, col = Species)) +
  geom_point(position = "jitter") +
  labs(x = "Sepal Length", y = "Sepal Width", col = "Species")


#### DUMMY AESTHETICS (y always need to be set)
# 1 - Create jittered plot of mtcars, mpg onto x, 0 onto y
ggplot(mtcars, aes(x = mpg, y = 0)) +
  geom_jitter()

# 2 - Add function to change y axis limits
ggplot(mtcars, aes(x = mpg, y = 0)) +
  geom_jitter() +
  scale_y_continuous(limits = c(-2,2))
