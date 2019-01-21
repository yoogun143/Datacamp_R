#### POINTS
# Load the MASS package
library(MASS)

# Plot Max.Price vs. Price as red triangles
plot(Cars93$Price, Cars93$Max.Price, pch = 17, col = "red")

# Add Min.Price vs. Price as blue circles
points(Cars93$Price, Cars93$Min.Price, pch = 16, col = "blue")

# Add an equality reference line with abline()
abline(a = 0, b = 1, lty = 2)


#### LINES
# Create the numerical vector x
x <- seq(0, 10, length = 200)

# Compute the Gaussian density for x with mean 2 and standard deviation 0.2
gauss1 <- dnorm(x, mean = 2, sd = 0.2)

# Compute the Gaussian density with mean 4 and standard deviation 0.5
gauss2 <- dnorm(x, mean = 4, sd = 0.5)

# Plot the first Gaussian density
plot(x, gauss1, type = "l", ylab = "Gaussian probability density")

# Add lines for the second Gaussian density
lines(x, gauss2, lwd = 3, lty = 2)


#### TRENDLINE FROM MODEL
# Build a linear regression model for the whiteside data
linear_model <- lm(Gas~Temp, data = whiteside)

# Create a Gas vs. Temp scatterplot from the whiteside data
plot(whiteside$Temp, whiteside$Gas)

# Use abline() to add the linear regression line
abline(linear_model, lty = 2)