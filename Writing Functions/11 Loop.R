df <- data.frame(x = c(2, 3), y = c(4,5))


# A safer way to create the sequence, handle empty data
# Replace the 1:ncol(df) sequence
for (i in seq_along(df)) {
  print(median(df[[i]]))
}

# Change the value of df
df <- data.frame()

# Not use seq_along
for (i in 1:ncol(df)) {
  print(median(df[[i]]))
}

# Repeat for loop to verify there is no error
for (i in seq_along(df)) {
  print(median(df[[i]]))
}


#### STORE OUTPUT, NOT SHOW => INCREASE EFFICIENCY
df <- data.frame(x = c(2, 3), y = c(4,5))
# Create new double vector: output
output <- vector("double", ncol(df)) # if you grow the for loop at each iteration (e.g. using c()), your for loop will be very slow.

# Alter the loop
for (i in seq_along(df)) {
  # Change code to store result in output
  output[[i]] <- median(df[[i]]) # You might ask why we are using double brackets here when output is a vector. It's primarily for generalizability: this subsetting will work whether output is a vector or a list.
}

# Print output
output
