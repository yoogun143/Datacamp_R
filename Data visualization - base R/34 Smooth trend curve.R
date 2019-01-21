# Create a scatterplot of MPG.city vs. Horsepower
plot(Cars93$Horsepower, Cars93$MPG.city)

# Call supsmu() to generate a smooth trend curve, with default bass
trend1 <- supsmu(Cars93$Horsepower, Cars93$MPG.city)

# Add this trend curve to the plot
lines(trend1)

# Call supsmu() for a second trend curve, with bass = 10
trend2 <- supsmu(Cars93$Horsepower, Cars93$MPG.city, bass = 10)

# Add this trend curve as a heavy, dotted line
lines(trend2, lty = 3, lwd = 2)