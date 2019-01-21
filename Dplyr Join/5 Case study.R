library(purrr)
library(dplyr)
library(Lahman)

# ANY KEYS SPAN THROUGH 28 DATASETS?
# Examine lahmanNames
lahmanNames

# Find variables in common
reduce(lahmanNames, intersect)


# COMMON KEYS
lahmanNames %>%  
  # Bind the data frames in lahmanNames
  bind_rows(.id = "dataframe") %>%
  # Group the result by var
  group_by(var) %>%
  # Tally the number of appearances
  summarise(n = n()) %>% # tally()
  # Filter the data
  filter(n > 1) %>% 
  # Arrange the results
  arrange(desc(n))


#### WHICH DATASETS USED PLAYERID?
lahmanNames %>% 
  # Bind the data frames
  bind_rows(.id = "dataframe") %>%
  # Filter the results
  filter(var == "playerID") %>% 
  # Extract the dataframe variable
  `$`(dataframe)


#### WHO ARE THE PLAYERS?
players <- Master %>% 
  # Return one row for each distinct player
  distinct(playerID, nameFirst, nameLast)


#### HOW MANY PLAYERS ARE COMPLETELY MISSING SALARY INFO?
players %>% 
  # Find all players who do not appear in Salaries
  anti_join(Salaries) %>%
  # Count them
  count() # = summarise(n())


#### MISS SALARY BECAUSE THEY DID NOT PLAY
players %>% 
  anti_join(Salaries, by = "playerID") %>% 
  # How many unsalaried players appear in Appearances?
  semi_join(Appearances, by = "playerID") %>% 
  count()


#### MAYBE UNSALARIED PLAYERS ONLY PLAYED 1 OR 2 GAMES, DID NOT EARN FULL SALARY
players %>% 
  # Find all players who do not appear in Salaries
  anti_join(Salaries, by = "playerID") %>% 
  # Join them to Appearances
  left_join(Appearances, by = "playerID") %>% 
  # Calculate total_games for each player
  group_by(playerID) %>%
  summarise(total_games = sum(G_all, na.rm = TRUE)) %>%
  # Arrange in descending order by total_games
  arrange(desc(total_games))


#### MAYBE UNSALARIED PLAYERS DID NOT ACTUALLY PLAY IN THE GAMES THAT THEY APPEARED IN (SUBSTITUTE)
players %>%
  # Find unsalaried players
  anti_join(Salaries, by = "playerID") %>% 
  # Join Batting to the unsalaried players
  left_join(Batting, by = "playerID") %>% 
  # Group by player
  group_by(playerID) %>% 
  # Sum at-bats for each player
  summarise(total_at_bat = sum(AB, na.rm = TRUE)) %>% 
  # Arrange in descending order
  arrange(desc(total_at_bat))
# => really miss salary info, not unsalaried players


#### HOW MANY PLAYERS HAVE BEEN NOMINATED FOR THE HALL OF FAME?
# Find the distinct players that appear in HallOfFame
nominated <- HallOfFame %>% 
  distinct(playerID)

nominated %>% 
  # Count the number of players in nominated
  count()

nominated_full <- nominated %>% 
  # Join to Master
  left_join(Master, by = "playerID") %>% 
  # Return playerID, nameFirst, nameLast
  select(playerID, nameFirst, nameLast)


#### HOW MANY WERE ADMITTED TO HALL OF FAME FROM NOMINATED?
# Find distinct players in HallOfFame with inducted == "Y"
inducted <- HallOfFame %>% 
  filter(inducted == "Y") %>% 
  distinct(playerID)

inducted %>% 
  # Count the number of players in inducted
  count()

inducted_full <- inducted %>% 
  # Join to Master
  left_join(Master, by = "playerID") %>% 
  # Return playerID, nameFirst, nameLast
  select(playerID, nameFirst, nameLast)


#### DID NOMINEES WHO WERE INDUCTED EARN MORE AWARDS?
# Tally the number of awards in AwardsPlayers by playerID
nAwards <- AwardsPlayers %>% 
  group_by(playerID) %>% 
  tally()

nAwards %>% 
  # Filter to just the players in inducted 
  semi_join(inducted, by = "playerID") %>% 
  # Calculate the mean number of awards per player
  summarize(avg_n = mean(n, na.rm = TRUE))

nAwards %>% 
  # Filter to just the players in nominated 
  semi_join(nominated, by = "playerID") %>%
  # Filter to players NOT in inducted 
  anti_join(inducted, by = "playerID") %>%
  # Calculate the mean number of awards per player
  summarize(avg_n = mean(n, na.rm = TRUE))


#### DOES MAXIMUM SALARY EARNED BY INDUCTEES TEND TO BE GREATER THAN NOMINEES NOT INDUCTED?
# Find the players who are in nominated, but not inducted
notInducted <- nominated %>% 
  setdiff(inducted)

Salaries %>% 
  # Find the players who are in notInducted
  semi_join(notInducted, by = "playerID") %>% 
  # Calculate the max salary by player
  group_by(playerID) %>% 
  summarise(max_salary = max(salary)) %>% 
  # Calculate the average of the max salaries
  summarise(avg_salary = mean(max_salary))

# Repeat for players who were inducted
Salaries %>% 
  semi_join(inducted, by = "playerID") %>% 
  group_by(playerID) %>% 
  summarise(max_salary = max(salary)) %>% 
  summarise(avg_salary = mean(max_salary))
# !!! Careful for missing salary


#### TEST FACT: PLAYERS CANNOT BE NOMINATED UNTIL 5 YEARS AFTER THEY RETIRE
Appearances %>% 
  # Filter Appearances against nominated
  semi_join(nominated, by = "playerID") %>% 
  # Find last year played by player
  group_by(playerID) %>% 
  summarise(last_year = max(yearID)) %>% 
  # Join to full HallOfFame
  left_join(HallOfFame, by = "playerID") %>% 
  # Filter for unusual observations
  filter(last_year >= yearID)
# Quite a few players have been nominated before they retired, but this practice seems much less frequent in recent years.