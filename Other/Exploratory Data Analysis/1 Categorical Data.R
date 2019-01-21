library(readr)
comics <- read_csv("E:/Datacamp/R/Other/Exploratory Data Analysis/comics.csv")
View(comics)

#### CONTINGENCY TABLE
# Print the first rows of the data
comics

# Check levels of align
comics$align <- as.factor(comics$align)
levels(comics$align)

# Check the levels of gender
comics$gender <- as.factor(comics$gender)
levels(comics$gender)

# Create a 2-way contingency table
table(comics$align, comics$gender)
# => Reformed Crim has low counts => need to be dropped to simplify the analysis


#### DROPPING LEVELS
# Load dplyr
library(dplyr)

# Remove align level
comics <- comics %>%
  filter(align != "Reformed Criminals") %>%
  droplevels()
table(comics$align, comics$gender)


#### SIDE-BY-SIDE BARCHARTS
# Load ggplot2
library(ggplot2)

# Create side-by-side barchart of gender by alignment
ggplot(comics, aes(x = align, fill = gender)) + 
  geom_bar(position = "dodge")

# Create side-by-side barchart of alignment by gender
ggplot(comics, aes(x = gender, fill = align)) + 
  geom_bar(position = "dodge") +
  theme(axis.text.x = element_text(angle = 90))
# => Across all genders, 'bad' is the most common alignment


#### CONDITIONAL PROPORTIONS
tab <- table(comics$align, comics$gender)
options(scipen = 999, digits = 3) # Print fewer digits
prop.table(tab)     # Joint proportions
prop.table(tab, 2)  # Conditional on columns, 1 for row


#### COUNTS VS PROPORTION
# Change the order of the levels in align
comics$align <- factor(comics$align, 
                       levels = c("Bad", "Neutral", "Good"))

# Plot of gender by align
ggplot(comics, aes(x = align, fill = gender)) +
  geom_bar()

# Plot proportion of gender, conditional on align
ggplot(comics, aes(x = align, fill = gender)) + 
  geom_bar(position = "fill") +
  ylab("proportion")
