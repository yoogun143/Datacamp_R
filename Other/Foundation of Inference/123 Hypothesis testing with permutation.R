#### EDA
# These data are collected by the CDC and can be thought of as a random sample of US residents.
# Load packages
library(dplyr)
library(ggplot2)
library(NHANES)

# What are the variables in the NHANES dataset?
names(NHANES)

# Create bar plot for Home Ownership by Gender
ggplot(NHANES, aes(x = Gender, fill = HomeOwn)) + 
  geom_bar(position = "fill") +
  ylab("Relative frequencies")

# Density for SleepHrsNight colored by SleepTrouble, faceted by HealthGen
ggplot(NHANES, aes(x = SleepHrsNight, col = SleepTrouble)) + 
  geom_density(adjust = 2) + 
  facet_wrap(~ HealthGen)


#### 1 PERMUTATION
# Subset the data: homes
homes <- NHANES %>%
  select(Gender, HomeOwn) %>%
  filter(HomeOwn %in% c("Own", "Rent"))

# Perform one permutation 
homes %>%
  mutate(HomeOwn_perm = sample(HomeOwn)) %>%
  group_by(Gender) %>%
  summarize(prop_own_perm = mean(HomeOwn_perm == "Own"), 
            prop_own = mean(HomeOwn == "Own")) %>%
  summarize(diff_perm = diff(prop_own_perm),
            diff_orig = diff(prop_own))


#### MANY PERMUTATION
# Define function create a new replicate column
rep_sample_n <- function (tbl, size, replace = FALSE, reps = 1) 
{
  n <- nrow(tbl)
  i <- unlist(replicate(reps, sample.int(n, size, replace = replace), 
                        simplify = FALSE))
  rep_tbl <- cbind(replicate = rep(1:reps, rep(size, reps)), 
                   tbl[i, ])
  dplyr::group_by(rep_tbl, replicate)
}

homes %>%
  rep_sample_n(size = nrow(homes), reps = 10)

# Perform 1000 permutations
homeown_perm <- homes %>%
  rep_sample_n(size = nrow(homes), reps = 1000) %>%
  mutate(HomeOwn_perm = sample(HomeOwn)) %>%
  group_by(replicate, Gender) %>%
  summarize(prop_own_perm = mean(HomeOwn_perm == "Own"), 
            prop_own = mean(HomeOwn == "Own")) %>%
  summarize(diff_perm = diff(prop_own_perm),
            diff_orig = diff(prop_own)) # male - female


# Density plot of 1000 permuted differences in proportions
ggplot(homeown_perm, aes(x = diff_perm)) +
  geom_dotplot(binwidth = .001)

# Plot permuted differences
ggplot(homeown_perm, aes(x = diff_perm)) + 
  geom_density() +
  geom_vline(aes(xintercept = diff_orig),
             col = "red")

# Compare permuted differences to observed difference
homeown_perm %>%
  summarize(sum(diff_orig >= diff_perm))
# => 21.2% of the null statistics, so you can conclude that the observed difference is consistent with the permuted distribution.
# =>  our data is consistent with the hypothesis of no difference in home ownership across gender.


#### CRITICAL REGION
# Find the 0.90, 0.95, and 0.99 quantiles of diff_perm
homeown_perm %>% 
  summarize(q.90 = quantile(diff_perm, p = 0.9),
            q.95 = quantile(diff_perm, p = 0.95),
            q.99 = quantile(diff_perm, p = 0.99))

# Find the 0.01, 0.05, and 0.10 quantiles of diff_perm
disc_perm %>% 
  summarise(q.01 = quantile(diff_perm, p = 0.01),
            q.05 = quantile(diff_perm, p = 0.05),
            q.10 = quantile(diff_perm, p = 0.1))


#### SAMPLE SIZE IN RANDOM DISTRIBUTION
setwd("E:/Datacamp/R/Other/Foundation of Inference")
disc_small <- readRDS('disc_small.rds')
disc_big <- readRDS('disc_big.rds')

# Tabulate the small and big data frames
disc_small %>% 
  select(sex, promote) %>%
  table()

disc_big %>% 
  select(sex, promote) %>%
  table()

disc_small_perm <- disc_small %>%
  rep_sample_n(size = nrow(disc_small), reps = 1000) %>%
  mutate(prom_perm = sample(promote)) %>%
  group_by(replicate, sex) %>%
  summarize(prop_prom_perm = mean(prom_perm == "promoted"),
            prop_prom = mean(promote == "promoted")) %>%
  summarize(diff_perm = diff(prop_prom_perm),
            diff_orig = diff(prop_prom))  # male - female

disc_big_perm <- disc_big %>%
  rep_sample_n(size = nrow(disc_big), reps = 1000) %>%
  mutate(prom_perm = sample(promote)) %>%
  group_by(replicate, sex) %>%
  summarize(prop_prom_perm = mean(prom_perm == "promoted"),
            prop_prom = mean(promote == "promoted")) %>%
  summarize(diff_perm = diff(prop_prom_perm),
            diff_orig = diff(prop_prom))  # male - female

# Plot the distributions of permuted differences
ggplot(disc_small_perm, aes(x = diff_perm)) + 
  geom_histogram(binwidth = 0.01) +
  geom_vline(aes(xintercept = diff_orig), col = "red")

ggplot(disc_big_perm, aes(x = diff_perm)) + 
  geom_histogram(binwidth = 0.01) +
  geom_vline(aes(xintercept = diff_orig), col = "red")


#### SAMPLE SIZE FOR CRITICAL REGION
# Calculate the quantiles associated with the small dataset
disc_small_perm %>% 
  summarize(q.90 = quantile(diff_perm, p = 0.90),
            q.95 = quantile(diff_perm, p = 0.95),
            q.99 = quantile(diff_perm, p = 0.99))

# Calculate the quantiles associated with the big dataset
disc_big_perm %>% 
  summarize(q.90 = quantile(diff_perm, p = 0.90),
            q.95 = quantile(diff_perm, p = 0.95),
            q.99 = quantile(diff_perm, p = 0.99))


#### P-VALUE
# Calculate the p-value for the small dataset
disc_small_perm %>%
  summarize(mean(diff_orig <= diff_perm))

# Calculate the p-value for the big dataset
disc_big_perm %>%
  summarize(mean(diff_orig <= diff_perm))

# Calculate the two-sided p-value
disc_big_perm %>%
  summarize(2 * mean(diff_orig <= diff_perm))
