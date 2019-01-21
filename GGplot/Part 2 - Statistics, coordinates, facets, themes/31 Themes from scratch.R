library(ggplot2)
z <- ggplot(mtcars, aes(x = wt, y = mpg, col = factor(cyl))) + geom_point() +
  facet_grid(.~cyl) +
  scale_x_continuous('Weight (lb/1000)') +
  scale_y_continuous('Miles/(US) gallon') +
  stat_smooth(method = 'lm', se = FALSE)
myPink = "#FEE0D2"
myRed = "#99000D"


#### RECTANGLES
# Plot 1: change the plot background color to myPink:
z + theme(plot.background = element_rect(fill = myPink))

# Plot 2: adjust the border to be a black line of size 3
z + theme(plot.background = element_rect(fill = myPink, color = "black", size = 3))

# Plot 3: set panel.background, legend.key, legend.background and strip.background to element_blank()
uniform_panels <- theme(panel.background = element_blank(), 
                        legend.key = element_blank(), 
                        legend.background=element_blank(), 
                        strip.background = element_blank())
z <- z + theme(plot.background = element_rect(fill = myPink, color = "black", size = 3)) + uniform_panels


#### LINES
# Extend z with theme() function and three arguments
z + theme(panel.grid = element_blank(),
          axis.line = element_line(color = "red"),
          axis.ticks = element_line(color = "red"))


#### TEXT
# Extend z with theme() function and four arguments
z + theme(strip.text = element_text(size = 16, color = myRed),
          axis.title.x = element_text(color = myRed, hjust = 0, face = "italic"),
          axis.title.y = element_text(color = myRed, hjust = 0, face = "italic"),
          axis.text = element_text(color = "black"))


#### LEGENDS
# Move legend by position
z + theme(legend.position = c(0.85, 0.85))

# Change direction
z + theme(legend.direction = "horizontal")

# Change location by name
z + theme(legend.position = "bottom")

# Remove legend entirely
z + theme(legend.position = "none")


#### POSITIONS
# Increase spacing between facets
library(grid)
z + theme(panel.spacing.x = unit(2, "cm"))


# Add code to remove any excess plot margin space
z + theme(panel.spacing.x = unit(2, "cm"),
          plot.margin = unit(c(0,0,0,0), "cm"))
