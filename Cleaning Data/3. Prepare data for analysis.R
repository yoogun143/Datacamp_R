students <- read.csv("E:/Datacamp/R/3. Cleaning Data/students_with_dates.csv")


#### TYPE CONVERSION
# Preview students with str()
str(students)

# Coerce Grades to character
students$Grades <- as.character(students$Grades)

# Coerce Medu to factor
students$Medu <- as.factor(students$Medu)

# Coerce Fedu to factor
students$Fedu <- as.factor(students$Fedu)

# Look at students once more with str()
str(students)


#### WORKING WITH DATES
# Preview students2 with str()
str(students)

# Load the lubridate package
library(lubridate)

# Parse as date
dmy("17 Sep 2015")

# Parse as date and time (with no seconds!)
mdy_hm("July 15, 2012 12:56")

# Coerce dob to a date (with no time)
students$dob <- mdy(students$dob)

# Coerce nurse_visit to a date and time
students$nurse_visit <- mdy_hms(students$nurse_visit)

# Look at students2 once more with str()
str(students)


#### STRING MANIPULATION
# Load the stringr package
library(stringr)

# Trim all leading and trailing whitespace
str_trim(c("   Filip ", "Nick  ", " Jonathan"))

# Pad these strings with leading zeros
str_pad(c("23485W", "8823453Q", "994Z"), width = 9, side = "left", pad = "0")

# Make states all uppercase and save result to states_upper
states_upper <- toupper('states')

# Make states_upper all lowercase again
tolower(states_upper)

# Look at the head of students2
head(students)

# Detect all dates of birth (dob) in 1997
str_detect(students$dob, "1997")

# In the sex column, replace "F" with "Female"...
students$sex <- str_replace(students$sex, "F", "Female")

# ...And "M" with "Male"
students$sex <- str_replace(students$sex, "M", "Male")

# View the head of students
head(students)


#### MISSING VALUES
# Call is.na() on the full students to spot all NAs
is.na(students)

# Use the any() function to ask whether there are any NAs in the data
any(is.na(students))

# View a summary() of the dataset
summary(students)

# Call table() on the status column to try searching for some of the usual suspects like "", "#N/A", etc. 
table(students$Mjob)

# Replace all empty strings in status with NA
students$Mjob[students$Mjob == ''] <- NA

# Use complete.cases() to see which rows have no missing values
complete.cases(students)

# Use na.omit() to remove all rows with any missing values
na.omit(students)


#### OUTLIERS AND OBVIOUS ERRORS
# Look at a summary() of students
summary(students)

# View a histogram of the absences variable
hist(students$absences)

# View a histogram of absences, but force zeros to be bucketed to the right of zero
hist(students$absences, right = FALSE)

# View a boxplot of absences
boxplot(students$absences)
