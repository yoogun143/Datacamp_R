# Load the robustbase package
library(robustbase)

# Set up the side-by-side plot array
par(mfrow = c(1,2))

# First plot: brain vs. body in its original form
plot(Animals2$body, Animals2$brain)

# Add the first title
title("Original representation")

# Second plot: log-log plot of brain vs. body
plot(Animals2$body, Animals2$brain, log = "xy")

# Add the second title
title("Log-log plot")