#### CREATE SAFE FUNCTION
# safely()  takes a function as an argument and it returns a function as its output.
# The function that is returned is modified so it never throws an error 
# always returns a list with 2 elements: result, error
# Define list of URLs
urls <- list(
  example = "http://example.org",
  rproj = "http://www.r-project.org",
  asdf = "http://asdfasdasdkfjlda"
)

# Create safe_readLines() by passing readLines() to safely()
safe_readLines <- safely(readLines)

# Use the safe_readLines() function with map(): html
html <- map(urls, safe_readLines)

# Call str() on html
str(html)

# Extract the result from one of the successful elements
html[["example"]][["result"]]

# Extract the error from the element that was unsuccessful
html[["asdf"]][["error"]]
# => output isn't easy to work with => need to be transposed

# Examine the structure of transpose(html)
str(transpose(html))

# Extract the results: res
res <- transpose(html)[["result"]]

# Extract the errors: errs
errs <- transpose(html)[["error"]]

# Create a logical vector is_ok
is_ok <- map_lgl(errs, is_null)

# Extract the successful results
res[is_ok]

# Extract the input from the unsuccessful results
urls[!is_ok]
