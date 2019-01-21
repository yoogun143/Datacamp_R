setwd("E:/Datacamp/R/Text Mining")
amzn = read.csv('500_amzn.csv')
goog = read.csv('500_goog.csv')
library(tm)

# Fill NA
amzn <- na.omit(amzn)
goog <- na.omit(goog)

# Print the structure of amzn
str(amzn)

# Create amzn_pros
amzn_pros <- amzn$pros

# Create amzn_cons
amzn_cons <- amzn$cons

# Print the structure of goog
str(goog)

# Create goog_pros
goog_pros <- goog$pros

# Create goog_cons
goog_cons <- goog$cons


#### TEXT ORGANIZATION
# qdap cleaning function
library(qdap)
qdap_clean <- function(x) {
  x <- replace_abbreviation(x)
  x <- replace_contraction(x)
  x <- replace_number(x)
  x <- replace_ordinal(x)
  x <- replace_symbol(x)
  x <- tolower(x)
  return(x)
}

# tm cleaning function
tm_clean <- function(corpus) {
  tm_clean <- tm_map(corpus, removePunctuation)
  corpus <- tm_map(corpus, stripWhitespace)
  corpus <- tm_map(corpus, removeWords,
                   c(stopwords("en"), "Google", "Amazon", "company"))
  return(corpus)
}

# Define clean function
clean <- function(x) {
  qdap_clean_a <- qdap_clean(x)
  corp <- VCorpus(VectorSource(qdap_clean_a))
  return(tm_clean(corp))
}

amzn_pros_corp <- clean(amzn_pros)
amzn_cons_corp <- clean(amzn_cons)
goog_pros_corp <- clean(goog_pros)
goog_cons_corp <- clean(goog_cons)


#### FEATURE EXTRACTION & ANALYSIS: AMZN_PROS
library(RWeka)
tokenizer <- function(x) {
  NGramTokenizer(x, Weka_control(min = 2, max = 2))
}

# Create amzn_p_tdm
amzn_p_tdm <- TermDocumentMatrix(amzn_pros_corp,
                                 control = list(tokenize = tokenizer))

# Create amzn_p_tdm_m
amzn_p_tdm_m <- as.matrix(amzn_p_tdm)

# Create amzn_p_freq
amzn_p_freq <- rowSums(amzn_p_tdm_m)

# Plot a wordcloud using amzn_p_freq values
library(wordcloud)
wordcloud(names(amzn_p_freq), amzn_p_freq, max.words = 25, color = "blue")


#### FEATURE EXTRACTION & ANALYSIS: AMZN_CONS
# Create amzn_c_tdm
amzn_c_tdm <- TermDocumentMatrix(amzn_cons_corp,
                                 control = list(tokenize = tokenizer))

# Create amzn_c_tdm_m
amzn_c_tdm_m <- as.matrix(amzn_c_tdm)

# Create amzn_c_freq
amzn_c_freq <- rowSums(amzn_c_tdm_m)

# Plot a wordcloud of negative Amazon bigrams
wordcloud(names(amzn_c_freq), amzn_c_freq, max.words = 25, color = "red")

# Create amzn_c_tdm
amzn_c_tdm <- TermDocumentMatrix(amzn_cons_corp,
                                 control = list(tokenize = tokenizer))

# Print amzn_c_tdm to the console
amzn_c_tdm

# Create amzn_c_tdm2 by removing sparse terms 
amzn_c_tdm2 <- removeSparseTerms(amzn_c_tdm, sparse = .993)

# Create hc as a cluster of distance values
hc <- hclust(dist(amzn_c_tdm2, method = "euclidean"), method = "complete")

# Produce a plot of hc
plot
# => there is a strong indication of long working hours and poor work-life balance


#### WORD ASSOCIATION
# Create amzn_p_tdm
amzn_p_tdm <- TermDocumentMatrix(amzn_pros_corp,
                                 control = list(tokenize = tokenizer))

# Create amzn_p_m
amzn_p_m <- as.matrix(amzn_p_tdm)

# Create amzn_p_freq
amzn_p_freq <- rowSums(amzn_p_m)

# Create term_frequency
term_frequency <- amzn_p_freq[order(amzn_p_freq, decreasing = TRUE)]

# Print the 5 most common terms
term_frequency[1:5]

# Find associations with fast paced
findAssocs(amzn_p_tdm, "fast paced", 0.2)


#### QUICK REVIEW OF GOOGLE
# Create all_goog_corp
all_goog_corpus <- c(paste(goog$pros, collapse = ' '), paste(goog$cons, collapse = ' '))
all_goog_corp <- clean(all_goog_corpus)

# Create all_tdm
all_tdm <- TermDocumentMatrix(all_goog_corp)

# Name the columns of all_tdm
colnames(all_tdm) <- c("Goog_Pros", "Goog_Cons")

# Create all_m
all_m <- as.matrix(all_tdm)

# Build a comparison cloud
comparison.cloud(all_m, 
                 colors = c("#F44336", "#2196f3"), 
                 max.words = 100)


#### PYRAMID PLOT (too lazy to do)