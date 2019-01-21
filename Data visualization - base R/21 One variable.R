#### HISTOGRAM
# Create a histogram of counts with hist()
hist(Cars93$Horsepower, main = "hist() plot")

# Create a normalized histogram with truehist()
hist(Cars93$Horsepower, main = "truehist() plot", freq = FALSE)

# Add the density curve to the histogram
lines(density(Cars93$Horsepower))


#### QQPLOT
# Load the car package to make qqPlot() available
library(car)

# Create index16, pointing to 16-week chicks
index16 <- which(ChickWeight$Time == 16)

# Get the 16-week chick weights
weights <- ChickWeight[index16,"weight"]

# Show the normal QQ-plot of the chick weights
qqPlot(weights)
hist(weights, freq = FALSE)

# Show the normal QQ-plot of the Boston$tax data
qqPlot(Boston$tax)
hist(Boston$tax)


#### AGGREGATION PLOT (part4)
# Set up a two-by-two plot array
par(mfrow = c(2,2))

# Plot the raw duration data
plot(geyser$duration, main = "Raw data")

# Plot the normalized histogram of the duration data
truehist(geyser$duration, main = "Histogram")

# Plot the density of the duration data
plot(density(geyser$duration), main = "Density")

# Construct the normal QQ-plot of the duration data
qqPlot(geyser$duration, main = "QQ-plot")