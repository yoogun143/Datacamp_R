# Load geomnet & examine structure of madmen
library(geomnet)
str(madmen)

# Merge edges and vertices
mmnet <- merge(madmen$edges, madmen$vertices,
               by.x = "Name1", by.y = "label",
               all = TRUE)

# Examine structure of mmnet
str(mmnet)

# Node colors
pink_and_blue <- c(female = "#FF69B4", male = "#0099ff")

# Tweak the network plot
ggplot(data = mmnet, aes(from_id = Name1, to_id = Name2)) +
  geom_net(aes(col = Gender),
           size = 6,
           linewidth = 1,
           labelon = TRUE,
           fontsize = 3,
           labelcolour = "black",
           # Make the graph directed
           directed = TRUE) +
  # Add manual color scale
  scale_color_manual(values = pink_and_blue) + 
  # Set x-axis limits
  xlim(c(-0.05, 1.05)) +
  # Set void theme
  theme_void()