# Define the dataframe df
df <- data.frame(
  a = rnorm(10),
  b = rnorm(10),
  c = rnorm(10),
  d = rnorm(10)
)
library(purrr)


#### THE ... ARGUMENT TO THE MAP FUNCTION
# The map functions use the ... ("dot dot dot") argument to pass along additional arguments to .f each time it's called. 
# Find the mean of each column
map_dbl(df, mean)

# Find the mean of each column, excluding missing values
map_dbl(df, mean, na.rm = TRUE)

# Find the 5th percentile of each column, excluding missing values
map_dbl(df, quantile, probs = 0.05, na.rm = TRUE)


#### PICK THE RIGHT MAP FUNCTION
# You can always use map(), which will return a list, but using the right function expect the error
# Find the columns that are numeric
map_lgl(df, is.numeric)

# Find the type of each column
map_chr(df, typeof)

# Find a summary of each column
map(df, summary)


#### SHORTCUTS USING A FORMULA
# Split dataframe mtcars based on cyl
cyl <- split(mtcars, mtcars$cyl)

# Rewrite to use the formula shortcut instead
map(cyl, ~ lm(mpg ~ wt, data = .))


#### SHORTCUT USING A STRING
# Save the result from the previous exercise to the variable models
models <- map(cyl, ~ lm(mpg ~ wt, data = .))

# Use map and coef to get the coefficients for each model: coefs
coefs <- map(models, coef)

# Use string shortcut to extract the wt coefficient 
map(coefs, "wt")

# Another way is to use numeric vector
map_dbl(coefs, 2)


#### MAP OVER 2 ARGUMENTS
# Initialize n
n <- list(5, 10, 20)

# Create a list mu containing the values: 1, 5, and 10
mu <- list(1, 5, 10)

# Edit to call map2() on n and mu with rnorm() to simulate three samples
map2(n, mu, rnorm)


#### MAP OVER MORE THAN 2 ARGUMENTS
# Initialize n and mu
n <- list(5, 10, 20)
mu <- list(1, 5, 10)

# Create a sd list with the values: 0.1, 1 and 0.1
sd <- list(0.1, 1, 0.1)

# Edit this call to pmap() to iterate over the sd list as well
pmap(list(n, mu, sd), rnorm)

# Name the elements of the argument list
pmap(list(mean = mu, n = n, sd = sd), rnorm) # => safer because match by argument, not position


#### MAP OVER FUNCTIONS AND ARGUMENTS
# Define list of functions
f <- list("rnorm", "runif", "rexp")

# Parameter list for rnorm()
rnorm_params <- list(mean = 10)

# Add a min element with value 0 and max element with value 5
runif_params <- list(min = 0, max = 5)

# Add a rate element with value 5
rexp_params <- list(rate = 5)

# Define params for each function
params <- list(
  rnorm_params,
  runif_params,
  rexp_params
)

# Call invoke_map() on f supplying params as the second argument
invoke_map(f, params, n = 5)


#### MAP WITH SIDE EFFECTS: WALK
# Side effects = printing, plotting or saving.
# Define list of functions
f <- list(Normal = "rnorm", Uniform = "runif", Exp = "rexp")

# Define params
params <- list(
  Normal = list(mean = 10),
  Uniform = list(min = 0, max = 5),
  Exp = list(rate = 5)
)

# Assign the simulated samples to sims
sims <- invoke_map(f, params, n = 50)

# Use walk() to make a histogram of each element in sims
walk(sims, hist)

# Replace "Sturges" with reasonable breaks for each sample
breaks_list <- list(
  Normal = seq(6, 16, 0.5),
  Uniform = seq(0, 5, 0.25),
  Exp = seq(0, 1.5, 0.1)
)


#### WALK WITH 2 ARGUMENTS
# Use walk2() to make histograms with the right breaks
walk2(sims, breaks_list, hist)


#### WALK AND MAP
# Generate reasonable breaks based on actual values in samples
# Turn this snippet into find_breaks()
find_breaks <- function(x) {
  rng <- range(x, na.rm = TRUE)
  seq(rng[1], rng[2], length.out = 30)
}

# Call find_breaks() on sims[[1]]
find_breaks(sims[[1]])

# Use map() to iterate find_breaks() over sims: nice_breaks
nice_breaks <- map(sims, find_breaks)

# Use nice_breaks as the second argument to walk2()
walk2(sims, nice_breaks, hist)


#### WALK WITH MANY ARGUMENTS
# Increase sample size to 1000
sims <- invoke_map(f, params, n = 1000)

# Compute nice_breaks (don't change this)
nice_breaks <- map(sims, find_breaks)

# Create a vector nice_titles
nice_titles <- list("Normal(10, 1)", "Uniform(0, 5)", "Exp(5)")

# Use pwalk() instead of walk2()
pwalk(list(x = sims, breaks = nice_breaks, main = nice_titles), hist, xlab = "")


#### WALK WITH PIPE
# Pipe this along to map(), using summary() as .f
sims %>%
  walk(hist) %>%
  map(summary)

# Structure of walk is the original sims object
str(sims %>% walk(hist))
