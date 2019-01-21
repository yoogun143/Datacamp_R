big_x <- function(df, threshold) {
  dplyr::filter(df, disp > threshold)
}

mtcars_sub = mtcars
# Use big_x() to find rows in mt_cars_sub where disp > 400
big_x(mtcars_sub, 400)

# Remove the disp column from mtcars_sub
mtcars_sub$disp <- NULL

# Create variable disp with value 1
disp <- 1

# Use big_x() to find rows in mtcars_sub where disp > 400
big_x(mtcars_sub, 400)

# Create a threshold column with value 100
mtcars_sub$threshold <- 100

# Use big_x() to find rows in mtcars_sub where disp > 400
big_x(mtcars_sub, 400)
# Reason for error
# 1: x does not exist in df
# 2: there is a threshold columns in df


#### WHAT TO DO
big_x <- function(df, threshold) {
  # Write a check for disp not being in df
  if(!"disp" %in% names(df)) {
    stop("df must contain variable called disp", call. = FALSE)
  }
  
  # Write a check for threshold being in df
  if("threshold" %in% names(df)) {
    stop("df must not contain variable called threshold", call. = FALSE)
  }
  
  dplyr::filter(df, x > threshold)
}