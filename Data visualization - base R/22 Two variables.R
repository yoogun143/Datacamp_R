# SCATTER PLOT AND SUNFLOWER PLOT
# Set up a side-by-side plot array
par(mfrow = c(1,2))

# Create the standard scatterplot
plot(rad ~ zn, data = Boston)

# Add the title
title("Standard scatterplot")

# Create the sunflowerplot
sunflowerplot(rad ~ zn, data = Boston)

# Add the title
title("Sunflower plot")


#### BOXPLOT
# Create a variable-width boxplot with log y-axis & horizontal labels
boxplot(crim ~ rad, data = Boston, varwidth = TRUE, las = 1, log = "y")

# Add a title
title("Crime rate vs. radial highway index")


#### MOSAIC PLOT
# Create a mosaic plot using the formula interface
mosaicplot(carb ~ cyl, data = mtcars)


#### MATPLOT = multi-dimensional SCATTERPLOT (part 4)
# Use matplot() to generate an array of three scatterplots
matplot(x = UScereal$calories, y = UScereal[c("protein"
                                  , "fat", "fibre")], xlab = "calories", ylab = "")
# Add a title
title("Three scatterplots")


#### SCATTERPLOT WITH SIZE
# Call symbols() to create the default bubbleplot
symbols(Cars93$Horsepower, Cars93$MPG.city,
        circles = sqrt(Cars93$Price))

# Repeat, with the inches argument specified
symbols(Cars93$Horsepower, Cars93$MPG.city,
        circles = sqrt(Cars93$Price),
        inches = 0.1)


#### AND THEN ADD MORE COLOR TO SCATTER PLOT
# Iliinsky and Steele color name vector
IScolors <- c("red", "green", "yellow", "blue",
              "black", "white", "pink", "cyan",
              "gray", "orange", "brown", "purple")
# Create the `cylinderLevel` variable
cylinderLevels <- as.numeric(Cars93$Cylinders)


# Create the colored bubbleplot
symbols(Cars93$Horsepower, Cars93$MPG.city, 
        circles = cylinderLevels, inches = 0.2, 
        bg = IScolors[cylinderLevels])