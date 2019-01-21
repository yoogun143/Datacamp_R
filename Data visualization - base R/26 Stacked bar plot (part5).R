# Iliinsky and Steele color name vector
IScolors <- c("red", "green", "yellow", "blue",
              "black", "white", "pink", "cyan",
              "gray", "orange", "brown", "purple")

# Create a table of Cylinders by Origin
tbl <- table(Cars93$Cylinders, Cars93$Origin)

# Create the default stacked barplot
barplot(tbl)

# Enhance this plot with color
barplot(tbl, col = IScolors)