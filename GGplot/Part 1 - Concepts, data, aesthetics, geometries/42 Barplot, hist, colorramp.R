library(ggplot2)
#### HISTOGRAMS
# 1 - Make a univariate histogram
ggplot(mtcars, aes(x = mpg)) +
  geom_histogram()

# 2 - Plot 1, plus set binwidth to 1 in the geom layer, default y = ..count..
ggplot(mtcars, aes(x = mpg)) +
  geom_histogram(binwidth = 1)

# 3 - Plot 2, plus MAP ..density.. to the y aesthetic (i.e. in a second aes() function)
ggplot(mtcars, aes(x = mpg)) +
  geom_histogram(aes(y = ..density..), binwidth = 1)

# 4 - plot 3, plus SET the fill attribute to "#377EB8"
ggplot(mtcars, aes(x = mpg)) +
  geom_histogram(aes(y = ..density..), binwidth = 1, fill = "#377EB8")


#### OVERLAPPING BARPLOT
# There are also 'stack', 'fill', 'identity'
# Define posn_d with position_dodge()
posn_d <- position_dodge(width = 0.2)

# 4 - Use posn_d as position and adjust alpha to 0.6
ggplot(mtcars, aes(x = cyl, fill = as.factor(am))) +
  geom_bar(position = posn_d, alpha = 0.6)


#### OVERLAPPING HIST
# A basic histogram, add coloring defined by cyl (default is stack)
ggplot(mtcars, aes(mpg, fill = as.factor(cyl))) +
  geom_histogram(binwidth = 1)

# Change position to identity
ggplot(mtcars, aes(mpg, fill = as.factor(cyl))) +
  geom_histogram(binwidth = 1, position = "identity")

# Change geom to freqpoly (position is identity by default)
ggplot(mtcars, aes(mpg, col = as.factor(cyl))) +
  geom_freqpoly(binwidth = 1)


#### BARPLOT WITH COLOR RAMP
# Example of how to use a brewed color palette
ggplot(mtcars, aes(x = cyl, fill = as.factor(am))) +
  geom_bar() +
  scale_fill_brewer(palette = "Set1")

# Use str() on Vocab to check out the structure
library(readr)
Vocab <- read_csv("E:/Datacamp/R/GGplot/Part 1 - Concepts, data, aesthetics, geometries/GSSvocab.csv")
str(Vocab)

# Plot education on x and vocabulary on fill
# Use the default brewed color palette
ggplot(Vocab, aes(x = educ, fill = as.factor(vocab))) +
  geom_bar(position = "fill") +
  scale_fill_brewer() # => Incomplete barplot

# Install package
library(RColorBrewer)

# Definition of a set of blue colors
blues <- brewer.pal(9, "Blues") # from the RColorBrewer package

# 1 - Make a color range using colorRampPalette() and the set of blues
blue_range <- colorRampPalette(blues)
blue_range(11) # the newly extrapolated colours
munsell::plot_hex(blue_range(11)) # Quick and dirty plot

# 2 - Use blue_range to adjust the color of the bars, use scale_fill_manual()
ggplot(Vocab, aes(x = educ, fill = as.factor(vocab))) +
  geom_bar(position = "fill") +
  scale_fill_manual(values = blue_range(11))

