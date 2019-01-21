library(GGally)
ggparcoord(iris, columns = 1:4, groupColumn = 5, scale = "globalminmax", order = "anyClass", alphaLines = 0.4)
