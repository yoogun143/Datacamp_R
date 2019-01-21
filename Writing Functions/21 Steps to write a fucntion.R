#### START WITH SIMPLE PROBLEM
# Define the dataframe df
df <- data.frame(
  a = rnorm(10),
  b = rnorm(10),
  c = rnorm(10),
  d = rnorm(10)
)


#### GET A WORKING SNIPPET OF CODE
# Rescale the a column in df to a 0-1 range
(df$a - min(df$a, na.rm = TRUE)) /
  (max(df$a, na.rm = TRUE) - min(df$a, na.rm = TRUE))


#### REWRITE TO USE TEMPORARY VARIABLES
# Assign a column to a temporary variable
x <- df$a

# Rewrite the code with temporary variable
( x - min( x , na.rm = TRUE)) /
  (max( x , na.rm = TRUE) - min( x , na.rm = TRUE))


#### REWRITE FOR CLARITY
# Assign a column to a temporary variable
x <- df$a

# Rewrite the min and max
rng <- range(x, na.rm = TRUE)

# Rewrite the code
(x - rng[1]) / (rng[2] - rng[1])


#### TURN INTO A FUNCTION
# Define the function
rescale01 <- function(x){
  rng <- range(x, na.rm = TRUE)
  (x - rng[1]) / (rng[2] - rng[1])
}

# Run the function
rescale01(df$a)