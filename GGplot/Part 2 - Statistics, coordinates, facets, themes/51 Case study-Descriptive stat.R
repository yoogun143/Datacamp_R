setwd("E:/Datacamp/R/GGplot/Part 2 - Statistics, coordinates, facets, themes")
adult <- dget('adult.txt')
library(ggplot2)


#### EXPLORE DATA
# Explore the dataset with summary and str
summary(adult)
str(adult)

# Age histogram
ggplot(adult, aes(x = SRAGE_P)) +
  geom_histogram()

# BMI histogram
ggplot(adult, aes(x = BMI_P)) +
  geom_histogram()

# Default binwidth
diff(range(adult$SRAGE_P))/30

# Age colored by BMI, default binwidth
ggplot(adult, aes(x = SRAGE_P, fill = factor(RBMI))) +
  geom_histogram(binwidth = 1)
# => There is an unexpectedly large number of very old people.


#### DATA CLEANING
# Remove individual aboves 84
adult <- adult[adult$SRAGE_P <= 84, ]

# Remove individuals with a BMI below 16 and above or equal to 52
adult <- adult[adult$BMI_P >= 16 & adult$BMI_P < 52, ]

# Relabel the race variable:
adult$RACEHPR2 <- factor(adult$RACEHPR2, labels = c("Latino", "Asian", "African American", "White"))

# Relabel the BMI categories variable:
adult$RBMI <- factor(adult$RBMI, labels = c("Under-weight", "Normal-weight", "Over-weight", "Obese"))


#### COUNT HISTOGRAM BY FACET
# The color scale used in the plot
BMI_fill <- scale_fill_brewer("BMI Category", palette = "Reds")

# Theme to fix category display in faceted plot
fix_strips <- theme(strip.text.y = element_text(angle = 0, hjust = 0, vjust = 0.1, size = 14),
                    strip.background = element_blank(),
                    legend.position = "none")

# Histogram, add BMI_fill and customizations
ggplot(adult, aes (x = SRAGE_P, fill= factor(RBMI))) +
  geom_histogram(binwidth = 1) +
  fix_strips+ BMI_fill +
  facet_grid(RBMI ~ .) + theme_classic()


#### DENSITY HISTOGRAM BY POSITION
# Plot 1 - Count histogram
ggplot(adult, aes (x = SRAGE_P, fill= factor(RBMI))) +
  geom_histogram(binwidth = 1) +
  BMI_fill

# Plot 2 - Density histogram
ggplot(adult, aes (x = SRAGE_P, fill= factor(RBMI))) +
  geom_histogram(aes(y = ..density..), binwidth = 1) +
  BMI_fill

# Plot 3 - Faceted count histogram
ggplot(adult, aes (x = SRAGE_P, fill= factor(RBMI))) +
  geom_histogram(binwidth = 1) +
  BMI_fill +
  facet_grid(RBMI ~ .)

# Plot 4 - Faceted density histogram
ggplot(adult, aes(x = SRAGE_P, fill= factor(RBMI))) +
  geom_histogram(aes(y = ..density..), binwidth = 1) +
  BMI_fill +
  facet_grid(RBMI ~ .)

# Plot 5 - Density histogram with position = "fill"
# This is not an accurate representation, as density calculates the proportion across category, and not across bin.
a <- ggplot(adult, aes(x = SRAGE_P, fill= factor(RBMI))) +
  geom_histogram(aes(y = ..density..), binwidth = 1, position = "fill") +
  BMI_fill
a
a_obs <- data.frame(ggplot_build(a)$data)
library(dplyr)
a_obs %>% filter(x == 18) %>%
  select(density, y) %>%
  mutate(calculate_perc = density/sum(density)) %>%
  mutate(calculate_y = cumsum(calculate_perc))

# Plot 6 - The accurate histogram
b <- ggplot(adult, aes (x = SRAGE_P, fill= factor(RBMI))) +
  geom_histogram(aes(y = ..count../sum(..count..)), binwidth = 1, position = "fill") +
  BMI_fill
b
b_obs <- data.frame(ggplot_build(b)$data)
b_obs %>% filter(x == 18) %>%
  select(count, y) %>%
  mutate(calculate_perc = count/sum(count)) %>%
  mutate(calculate_y = cumsum(calculate_perc))


#### DENSITY HISTOGRAM BY FACET
# An attempt to facet the accurate frequency histogram from before (failed)
# the calculation occurs on the fly inside ggplot2
c <- ggplot(adult, aes (x = SRAGE_P, fill= factor(RBMI))) +
  geom_histogram(aes(y = ..count../sum(..count..)), binwidth = 1, position = "fill") +
  BMI_fill +
  facet_grid(RBMI ~ .)
c
c_obs <- data.frame(ggplot_build(c)$data)

# Create DF with table()
DF <- table(adult$RBMI, adult$SRAGE_P)

# Use apply on DF to get frequency of each group: DF_freq
DF_freq <- apply(DF, 2, function(x) x/sum(x))

# Load reshape2 and use melt() on DF_freq to create DF_melted
library(reshape2)
DF_melted <- melt(DF_freq)

# Change names of DF_melted
names(DF_melted) <- c("FILL", "X", "value")

# Add code to make this a faceted plot
ggplot(DF_melted, aes(x = X, y = value, fill = FILL)) +
  geom_col(position = "stack") +
  BMI_fill + 
  facet_grid(FILL ~ .)
