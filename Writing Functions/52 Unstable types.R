df <- data.frame(
  a = 1L,
  b = 1.5,
  y = Sys.time(),
  z = ordered(1)
)


#### USE PURRR SOLVES THE PROBLEM
# sapply calls
A <- sapply(df[1:4], class) 
B <- sapply(df[3:4], class)
C <- sapply(df[1:2], class) 

# Demonstrate type inconsistency
str(A)
str(B)
str(C)

# Use map() to define X, Y and Z
X <- map(df[1:4], class)
Y <- map(df[3:4], class)
Z <- map(df[1:2], class)

# Use str() to check type consistency
str(X)
str(Y)
str(Z)


#### A TYPE CONSISTENT SOLUTION
# what if you wanted this function to always return a character string?
# One option would be to decide what should happen if class() returns something longer than length 1. For example, we might simply take the first element of the vector returned by class().
col_classes <- function(df) {
  # Assign list output to class_list
  class_list <- map(df, class)
  
  # Use map_chr() to extract first element in class_list
  map_chr(class_list, 1)  
}

# Check that our new function is type consistent
df %>% col_classes() %>% str()
df[3:4] %>% col_classes() %>% str()
df[1:2] %>% col_classes() %>% str()


#### OR FAIL EARLY IF SOMETHING GOES WRONG
# y and z in df has 2 classes in each columns => should throw an error to alert
col_classes <- function(df) {
  class_list <- map(df, class)
  
  # Add a check that no element of class_list has length > 1
  if (any(map_dbl(class_list, length) > 1)) {
    stop("Some columns have more than one class", call. = FALSE)
  }
  
  # Use flatten_chr() to return a character vector
  flatten_chr(class_list)
}

# Check that our new function is type consistent
df %>% col_classes() %>% str()
df[3:4] %>% col_classes() %>% str()
df[1:2] %>% col_classes() %>% str()