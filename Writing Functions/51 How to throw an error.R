#### STOPIFNOT()
# Define troublesome x and y
x <- c(NA, NA, NA)
y <- c( 1, NA, NA, NA)

# Initial function to finds number of entries where x and y both missing
both_na <- function(x, y) {
  sum(is.na(x) & is.na(y))
}
# Call both_na() on x and y
both_na(x, y)
# => The function works and returns 3, but we certainly didn't design this function with the idea that people could pass in different length arguments.

# Alter the function to throw an error
both_na <- function(x, y) {
  # Add stopifnot() to check length of x and y
  stopifnot(length(x) == length(y))
  
  sum(is.na(x) & is.na(y))
}

# Call both_na() on x and y
both_na(x, y)


#### INFORMATIVE ERROR WITH STOP()
# Alter function to use informative error
both_na <- function(x, y) {
  # Replace condition with logical
  if (length(x) != length(y)) {
    # Replace "Error" with better message
    stop("x and y must have the same length", call. = FALSE)
  }  
  
  sum(is.na(x) & is.na(y))
}

# Call both_na() 
both_na(x, y)