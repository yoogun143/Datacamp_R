# Create a table of Cylinders frequencies
tbl <- table(Cars93$Cylinders)

# Generate a horizontal barplot of these frequencies
mids <- barplot(tbl, horiz = TRUE,
                col = "transparent",
                names.arg = "")

# Add names labels with text()
text(20, mids, names(tbl))

# Add count labels with text()
text(35, mids, as.numeric(tbl))