#### ADDING CUSTOM AXES
# Create a boxplot of sugars by shelf value, without axes
boxplot(sugars~shelf, data = UScereal, axes = FALSE)

# Add a default y-axis to the left of the boxplot
axis(side = 2)

# Add an x-axis below the plot, labelled 1, 2, and 3
axis(side = 1, at = c(1,2,3))

# Add a second x-axis above the plot
axis(side = 3, at = c(1,2,3),
     labels = c("floor", "middle", "top"))
