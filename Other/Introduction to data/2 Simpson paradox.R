# Load packages
library(dplyr)
library(tidyr)


#### NUMBER OF MALES AND FEMALES ADMITTED
# Count number of male and female applicants admitted
ucb_counts <- ucb_admit %>%
  count(Admit, Gender)

# View result
ucb_counts

# Spread the output across columns
ucb_counts %>%
  spread(Admit, n)


#### PROPORTION OF MALES ADMITTED OVERALL
ucb_admit %>%
  # Table of counts of admission status and gender
  count(Admit, Gender) %>%
  # Spread output across columns based on admission status
  spread(Admit, n) %>%
  # Create new variable
  mutate(Perc_Admit = Admitted / (Admitted + Rejected))


#### PROPORTION OF MALES ADMITTED FOR EACH DEPARTMENT
ucb_admission_counts <- ucb_admit %>%
  # Counts by department, then gender, then admission status
  count(Dept, Gender, Admit)

# See the result
ucb_admission_counts

ucb_admission_counts  %>%
  # Group by department, then gender
  group_by(Dept, Gender) %>%
  # Create new variable
  mutate(prop = n / sum(n)) %>%
  # Filter for male and admitted
  filter(Gender == "Male", Admit == "Admitted")
# => Within most departments, female applicants are more likely to be admitted.
