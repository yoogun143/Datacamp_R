setwd("E:/Datacamp/R/Text Mining")
# Load qdap
library(qdap)

# Import text data
tweets <- read.csv("coffee.csv", stringsAsFactors = FALSE)

# View the structure of tweets
str(tweets)

# Print out the number of rows in tweets
nrow(tweets)

# Isolate text from tweets: coffee_tweets
coffee_tweets <- tweets$text


#### VCORPUS
# Load tm
library(tm)

# Make a vector source: coffee_source
coffee_source <- VectorSource(coffee_tweets)

# Make a volatile corpus: coffee_corpus
coffee_corpus <- VCorpus(coffee_source)

# Print out coffee_corpus
coffee_corpus

# Print data on the 15th tweet in coffee_corpus
coffee_corpus[[15]]

# Print the content of the 15th tweet in coffee_corpus
coffee_corpus[[15]]$content


#### CLEANING WITH BASE
# Create the object: text
text <- "<b>She</b> woke up at       6 A.M. It\'s so early!  She was only 10% awake and began drinking coffee in front of her computer."

# All lowercase
tolower(text)

# Remove punctuation
removePunctuation(text)

# Remove numbers
removeNumbers(text)

# Remove whitespace
stripWhitespace(text)


#### CLEANING WITH QDAP
# Remove text within brackets
bracketX(text)

# Replace numbers with words
replace_number(text)

# Replace abbreviations
replace_abbreviation(text)

# Replace contractions
replace_contraction(text)

# Replace symbols with words
replace_symbol(text)


#### STOP WORDS
# List standard English stop words
stopwords("en")

# Print text without standard stop words
removeWords(text, stopwords("en"))

# Add "coffee" and "bean" to the list: new_stops
new_stops <- c("coffee", "bean", stopwords("en"))

# Remove stop words from text
removeWords(text, new_stops)


#### WORD STEMMING AND STEM COMPLETION
# Create complicate
complicate <- c("complicated", "complication", "complicatedly")

# Perform word stemming: stem_doc
stem_doc <- stemDocument(complicate)
stem_doc
# => meaningless => reconstruct these word roots back into a known term

# Create the completion dictionary: comp_dict
comp_dict <- "complicate"

# Perform stem completion: complete_text 
complete_text <- stemCompletion(stem_doc, comp_dict)

# Print complete_text
complete_text

# On sentence
text_data <- "In a complicated haste, Tom rushed to fix a new complication, too complicatedly."
stemDocument(text_data) # => not work

# Remove punctuation: rm_punc
rm_punc <- removePunctuation(text_data)

# Create character vector: n_char_vec
n_char_vec <- unlist(strsplit(rm_punc, split = ' '))

# Perform word stemming: stem_doc
stem_doc <- stemDocument(n_char_vec)

# Print stem_doc
stem_doc

# Re-complete stemmed document: complete_doc
complete_doc <- stemCompletion(stem_doc, comp_dict)

# Print complete_doc
complete_doc


#### COMBINE PREPROCESSING INTO FUNCTION
# Alter the function code to match the instructions
clean_corpus <- function(corpus) {
  # Remove punctuation
  corpus <- tm_map(corpus, removePunctuation)
  # Transform to lower case
  corpus <- tm_map(corpus, content_transformer(tolower)) # content transfomer for base R
  # Add more stopwords
  corpus <- tm_map(corpus, removeWords, c(stopwords("en"), "coffee", "mug"))
  # Strip whitespace
  corpus <- tm_map(corpus, stripWhitespace)
  return(corpus)
}


#### DOCUMENT TERM MATRIX
clean_corp <- clean_corpus(coffee_corpus)

# Create the dtm from the corpus: coffee_dtm
coffee_tdm <- TermDocumentMatrix(clean_corp)

# Print out coffee_dtm data
coffee_tdm

# Convert coffee_dtm to a matrix: coffee_m
coffee_m <- as.matrix(coffee_tdm)

# Print the dimensions of coffee_m
dim(coffee_m)

# Review a portion of the matrix
coffee_m[2587:2590, 148:150]


#### FREQUENT TERMS WITH TM
# Calculate the rowSums: term_frequency
term_frequency <- rowSums(coffee_m)

# Sort term_frequency in descending order
term_frequency <- sort(term_frequency, decreasing = TRUE)

# View the top 10 most common words
term_frequency[1:10]

# Plot a barchart of the 10 most common words
barplot(term_frequency[1:10], col = "tan", las = 2)

# Another way of frequent term
# Create frequency
frequency <- freq_terms(
  tweets$text, 
  top = 10, 
  at.least = 3, 
  stopwords = "Top200Words"
)

# Make a frequency barchart
plot(frequency)


#### WORDCLOUD
# Load wordcloud package
library(wordcloud)

# Print the first 10 entries in term_frequency
term_frequency[1:10]

# Create word_freqs
word_freqs <- data.frame(term = names(term_frequency), num = term_frequency)

# Print the list of colors
colors()

# Create a wordcloud for the values in word_freqs
wordcloud(word_freqs$term, word_freqs$num, max.words = 100, colors = c("grey80", "darkgoldenrod1", "tomato"))

# List the available colors
display.brewer.all()

# Create purple_orange
purple_orange <- brewer.pal(10, "PuOr")

# Drop 2 faintest colors
purple_orange <- purple_orange[-(1:2)]

# Create a wordcloud with purple_orange palette
wordcloud(word_freqs$term, word_freqs$num, max.words = 100, colors = purple_orange)


#### COMMONALITY CLOUD AND COMPARISON CLOUD
coffee_tweets <- read.csv("coffee.csv", stringsAsFactors = FALSE)
chardonnay_tweets <- read.csv('chardonnay.csv', stringsAsFactors = FALSE)

# Create all_coffee
all_coffee <- paste(coffee_tweets$text, collapse = " ")

# Create all_chardonnay
all_chardonnay <- paste(chardonnay_tweets$text, collapse = " ")

# Create all_tweets
all_tweets <- c(all_coffee, all_chardonnay)

# Convert to a vector source
all_tweets <- VectorSource(all_tweets)

# Create all_corpus
all_corpus <- VCorpus(all_tweets)

# Clean the corpus
all_clean <- clean_corpus(all_corpus)

# Create all_tdm
all_tdm <- TermDocumentMatrix(all_clean)

# Give the columns distinct names
colnames(all_tdm) <- c("coffee", "chardonnay")

# Create all_m
all_m <- as.matrix(all_tdm)

# Print a commonality cloud
commonality.cloud(all_m, colors = "steelblue1", max.words = 100)

# Create comparison cloud
comparison.cloud(all_m, colors = c("orange", "blue"), max.words = 50)


#### PYRAMID PLOT: UPGRADE TO COMMONALITY CLOUD
library(dplyr)
library(plotrix)

top25_df <- all_m %>%
  # Convert to data frame
  as_data_frame(rownames = "word") %>% 
  # Keep rows where word appears everywhere
  filter_all(all_vars(. > 0)) %>% 
  # Get difference in counts
  mutate(difference = chardonnay - coffee) %>% 
  # Keep rows with biggest difference
  top_n(25, wt = difference) %>% 
  # Arrange by descending difference
  arrange(desc(difference))

# Make pyramid plot
pyramid.plot(top25_df$chardonnay, top25_df$coffee,
             labels = top25_df$word,
             main = "Words in Common",
             gap = 8,
             raxlab = NULL, unit = NULL,
             top.labels = c("Chardonnay",
                            "Words",
                            "Coffee"))


#### WORD NETWORK
# Word association
word_associate(chardonnay_tweets$text, match.string = "marvin", 
               stopwords = c(Top200Words, "chardonnay", "amp"), 
               network.plot = TRUE, cloud.colors = c("gray85", "darkred"))

# Add title
title(main = "Chardonnay Tweets Associated with Marvin")


#### REMOVE SPARSE TERM
# TDMs and DTMs are sparse, meaning they contain mostly zeros. 
# Print the dimensions of tweets_tdm
dim(coffee_tdm)

# Create tdm1
tdm1 <- removeSparseTerms(coffee_tdm, sparse = 0.95)

# Create tdm2
tdm2 <- removeSparseTerms(coffee_tdm, sparse = 0.975)

# Print tdm1
tdm1

# Print tdm2
tdm2

# Create tdm_m
tdm_m <- as.matrix(tdm2)

# Create tdm_df
tdm_df <- as.data.frame(tdm_m)

# Create tweets_dist
tweets_dist <- dist(tdm_df)

# Create hc
hc <- hclust(tweets_dist)

# Plot the dendrogram
plot(hc)

# Load dendextend
library(dendextend)

# Create hcd
hcd <- as.dendrogram(hc)

# Print the labels in hcd
labels(hcd)

# Change the branch color to red for "cup" and "tea"
hcd_colored <- branches_attr_by_labels(hcd, c("cup", "tea"), "red")

# Plot hcd
plot(hcd_colored, main = "Better Dendrogram")

# Add cluster rectangles 
rect.dendrogram(hcd_colored, k = 2, border = "grey50")


#### WORD ASSOCIATION
library(ggplot2)
library(ggthemes)
# Create associations
associations <- findAssocs(coffee_tdm, "venti", 0.2)

# View the venti associations
associations

# Create associations_df
associations_df <- list_vect2df(associations)[,2:3]

# Plot the associations_df values (don't change this)
ggplot(associations_df, aes(y = associations_df[, 1])) + 
  geom_point(aes(x = associations_df[, 2]), 
             data = associations_df, size = 3) + 
  theme_gdocs()


#### N-GRAM
library(RWeka)

# Make tokenizer function 
tokenizer <- function(x) {
  NGramTokenizer(x, Weka_control(min = 2, max = 2))
}

# Create unigram_dtm
unigram_dtm <- DocumentTermMatrix(clean_corp)

# Create bigram_dtm
bigram_dtm <- DocumentTermMatrix(
  clean_corp, 
  control = list(tokenize = tokenizer)
)

# Print unigram_dtm
unigram_dtm

# Print bigram_dtm
bigram_dtm 
# => there are more term

# Create bigram_dtm_m
bigram_dtm_m <- as.matrix(bigram_dtm)

# Create freq
freq <- colSums(bigram_dtm_m)

# Create bi_words
bi_words <- names(freq)

# Examine part of bi_words
bi_words[2577:2587]

# Plot a wordcloud
wordcloud(bi_words, freq, max.words = 15)


#### CHANGE FREQUENCY WEIGHT (TF-IDF)
# TF-IDF penalize those words happen many times across documents
# Create a TDM
tdm <- TermDocumentMatrix(
  clean_corp, 
  control = list(weighting = weightTfIdf)
)
