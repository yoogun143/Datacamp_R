#### SPAM & NUM_CHAR
# Load packages
library(dplyr)
library(ggplot2)
library(openintro)

# Compute summary statistics
email %>%
  group_by(spam) %>%
  summarize(median(num_char), IQR(num_char))

# Create plot
email %>%
  mutate(log_num_char = log(num_char)) %>%
  ggplot(aes(x = spam, y = log_num_char)) +
  geom_boxplot()
# => The median length of not-spam emails is greater than that of spam emails.


#### SPAM AND !!!
# exclaim_mess = number of exclamation marks in each message
# Compute center and spread for exclaim_mess by spam
email %>%
  group_by(spam) %>%
  summarize(median(exclaim_mess), IQR(exclaim_mess))

# Create plot for spam and exclaim_mess
email %>%
  ggplot(aes(x = exclaim_mess, fill = as.factor(spam))) +
  geom_density(alpha = 0.3)
email %>%
  ggplot(aes(x = log(exclaim_mess + .01), fill = as.factor(spam))) +
  geom_density(alpha = 0.3) # log(0) = -Inf => add .01


#### COLLAPSE LEVEL
table(email$image) # => should be collapsed into categorical variables

# Create plot of proportion of spam by image
email %>%
  mutate(has_image = image != 0) %>%
  ggplot(aes(x = has_image, fill = as.factor(spam))) +
  geom_bar(position = "fill")
# => An email without an image is more likely to be not-spam than spam.


#### DATA INTEGRITY
sum(email$num_char < 0) # => good data

# Test if images count as attachments
sum(email$image > email$attach) # => images are counted as attachments


#### WHAT'S IN A NUMBER?
# Reorder levels
email$number <- factor(email$number,
                       levels = c("none", "small", "big"))

# Construct plot of number
ggplot(email, aes(x = number)) +
  geom_bar() +
  facet_wrap(~spam)
