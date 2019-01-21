#### ADD ANNOTATION
# Plot MPG.city vs. Horsepower as open circles
plot(Cars93$Horsepower, Cars93$MPG.city, pch = 1)

# Create index3, pointing to 3-cylinder cars
index3 <- which(Cars93$Cylinders == 3)

# Highlight 3-cylinder cars as solid circles
points(Cars93$Horsepower[index3], Cars93$MPG.city[index3], pch = 16)

# Add car names, offset from points, with larger bold text
text(x = Cars93$Horsepower[index3], 
     y = Cars93$MPG.city[index3], 
     adj = -0.2, cex = 1.2, font = 4, srt = -10, 
     labels = Cars93$Make[index3])