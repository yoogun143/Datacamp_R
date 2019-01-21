# Set up and label empty plot of Gas vs. Temp
plot(whiteside$Temp, whiteside$Gas,
     type = "n", xlab = "Outside temperature",
     ylab = "Heating gas consumption")

# Create indexB, pointing to "Before" data
indexB <- which(whiteside$Insul == "Before")

# Create indexA, pointing to "After" data
indexA <- which(whiteside$Insul == "After")

# Add "Before" data as solid triangles
points(x = whiteside$Temp[indexB], y = whiteside$Gas[indexB], pch = 17)

# Add "After" data as open circles
points(x = whiteside$Temp[indexA], y = whiteside$Gas[indexA], pch = 1)

# Add legend that identifies points as "Before" and "After"
legend("topright", pch = c(17,1), 
       legend = c("Before", "After"))