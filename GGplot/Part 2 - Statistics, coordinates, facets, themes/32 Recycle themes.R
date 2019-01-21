#### UPDATING THEMES
# Original plot
library(ggplot2)
z <- ggplot(mtcars, aes(x = wt, y = mpg, col = factor(cyl))) + geom_point() +
  facet_grid(.~cyl) +
  scale_x_continuous('Weight (lb/1000)') +
  scale_y_continuous('Miles/(US) gallon') +
  stat_smooth(method = 'lm', se = FALSE)
myPink = "#FEE0D2"
myRed = "#99000D"
z

# Theme layer saved as an object, theme_pink
theme_pink <- theme(panel.background = element_blank(),
                    legend.key = element_blank(),
                    legend.background = element_blank(),
                    strip.background = element_blank(),
                    plot.background = element_rect(fill = myPink, color = "black", size = 3),
                    panel.grid = element_blank(),
                    axis.line = element_line(color = "red"),
                    axis.ticks = element_line(color = "red"),
                    strip.text = element_text(size = 16, color = myRed),
                    axis.title.y = element_text(color = myRed, hjust = 0, face = "italic"),
                    axis.title.x = element_text(color = myRed, hjust = 0, face = "italic"),
                    axis.text = element_text(color = "black"),
                    legend.position = "none")

# 1 - Apply theme_pink to z2
z + 
  theme_pink

# 2 - Update the default theme, and at the same time
# assign the old theme to the object old.
old <- theme_update(panel.background = element_blank(),
                    legend.key = element_blank(),
                    legend.background = element_blank(),
                    strip.background = element_blank(),
                    plot.background = element_rect(fill = myPink, color = "black", size = 3),
                    panel.grid = element_blank(),
                    axis.line = element_line(color = "red"),
                    axis.ticks = element_line(color = "red"),
                    strip.text = element_text(size = 16, color = myRed),
                    axis.title.y = element_text(color = myRed, hjust = 0, face = "italic"),
                    axis.title.x = element_text(color = myRed, hjust = 0, face = "italic"),
                    axis.text = element_text(color = "black"),
                    legend.position = "none")

# 3 - Display the plot z2 - new default theme used
z

# 4 - Restore the old default theme
theme_set(old)

# Display the plot z2 - old theme restored
z


#### GGTHEMES
# Load ggthemes package
library(ggthemes)

# Apply theme_tufte
z + theme_tufte()


# Apply theme_tufte, modified:
z + theme_tufte() + 
  theme(legend.position = c(0.9, 0.9),
        legend.title = element_text(face = "italic", size = 12),
        axis.title = element_text(face = "bold", size = 14))


