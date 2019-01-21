# (x): not in the lesson
# Load the DBI package
library(DBI)
library(RMySQL)


# Create connection to MySQL on localhost (x)
con = dbConnect(MySQL(), 
                user = 'root', 
                password = '1234', 
                dbname = 'test',
                host = 'localhost')


# Edit dbConnect() call
con <- dbConnect(MySQL(), 
                 dbname = "tweater", 
                 host = "courses.csrrinzqubik.us-east-1.rds.amazonaws.com", 
                 port = 3306,
                 user = "student",
                 password = "datacamp")


#### GET TABLE NAMES IN SCHEMA
# Get table names: tables
table_names <- dbListTables(con)

# Display structure of tables
str(table_names)

#### IMPORT 1 TABLE
# Import the users table from tweater: users
users <- dbReadTable(con, "users")

# Print users
users

#### IMPORT ALL TABLES
# Import all tables
tables <- lapply(table_names, dbReadTable, conn = con)

# Print out tables
tables

#### SOME QUERY
# Create data frame specific
specific <- dbGetQuery(con, "SELECT message FROM comments WHERE tweat_id = 77 and user_id > 4")

# Print specific
specific

# Create data frame short
short <- dbGetQuery(con, "SELECT id, name FROM users WHERE char_length(name) < 5")

# Print short
short

# Create dataframe join
join <- dbGetQuery(con, "SELECT post, message
  FROM tweats INNER JOIN comments on tweats.id = tweat_id
                   WHERE tweat_id = 77")

# Print join
join

#### ALTERNATIVE TO DBGETQUERY, FETCH RESULTS IN CHUNK
# Send query to the database
res <- dbSendQuery(con, "SELECT * FROM comments WHERE user_id > 4")

# Fetching the result of executing the query on the database
dbFetch(res, n =2)
dbFetch(res)

# Clear res
dbClearResult(res)

#### DISCONNECT DATABASE
# Disconnect from the database
dbDisconnect(con)
