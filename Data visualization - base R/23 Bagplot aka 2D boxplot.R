# Create a side-by-side boxplot summary
boxplot(Cars93$Min.Price, Cars93$Max.Price)

# Load aplpack to make the bagplot() function available
library(aplpack)

# Create a bagplot for the same two variables
bagplot(Cars93$Min.Price, Cars93$Max.Price, cex = 1.2)

# Add an equality reference line
abline(a = 0, b = 1, lty = 2)
