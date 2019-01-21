# Load the jsonlite package
library(jsonlite)

#### IMPORT JSON FROM OMDBAPI.COM API(should visit website)
# Definition of the URLs for Infinity War
url_sw4 <- "http://www.omdbapi.com/?apikey=ff21610b&s=Infinity%20War&r=json"

# Import  URLs with fromJSON()
sw4 <- fromJSON(url_sw4)

# Print structure of sw4
str(sw4)

#### TRANSPOSE TO JSON FROM DATAFRAME
toJSON(sw4)

#### MINIFY AND PRETTIFY JSON
(pretty_sw4 <- toJSON(sw4, pretty = TRUE))
minify(pretty_sw4)
