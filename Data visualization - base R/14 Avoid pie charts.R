# Load the insuranceData package
library(insuranceData)

# Use the data() function to get the dataCar data frame
data(dataCar)

# Set up a side-by-side plot array
par(mfrow = c(1,2))

# Create a table of veh_body record counts and sort
tbl <- sort(table(dataCar$veh_body),
            decreasing = TRUE)

# Create the pie chart and give it a title
pie(tbl)
title("Pie chart")
# Create the barplot with perpendicular, half-sized labels
barplot(tbl, las = 2, cex.names = 0.5)

# Add a title
title("Bar chart")