# Simple random sample: states_srs
states_srs <- us_regions %>%
  sample_n(8)

# Count states by region
states_srs %>%
  group_by(region) %>%
  count()
