setwd("E:/Datacamp/R/Unsupervised Learning")
x <- read.csv('seeds.csv')
x <- x[1:2]
pokemon = read.csv('pokemon.csv')
pokemon = pokemon[c('HitPoints', 'Attack', 'Defense', 'SpecialAttack', 'SpecialDefense', 'Speed')]

# Create hierarchical clustering model: hclust.out
hclust.out <- hclust(dist(x))

# Inspect the result
summary(hclust.out)


#### CUT TREE
# Cut by height
cutree(hclust.out, h = 7)

# Cut by number of clusters
cutree(hclust.out, k = 3)


#### LINKAGE
# Cluster using complete linkage: hclust.complete
hclust.complete <- hclust(dist(x), method = "complete")

# Cluster using average linkage: hclust.average
hclust.average <- hclust(dist(x), method = "average")

# Cluster using single linkage: hclust.single
hclust.single <- hclust(dist(x), method = "single")

# Plot dendrogram of hclust.complete
plot(hclust.complete, main = "Complete")

# Plot dendrogram of hclust.average
plot(hclust.average, main = "Average")

# Plot dendrogram of hclust.single
plot(hclust.single, main = "Single")


#### SCALING
# View column means
colMeans(pokemon)

# View column standard deviations
apply(pokemon, 2, sd)

# Scale the data
pokemon.scaled <- scale(pokemon)

# Create hierarchical clustering model: hclust.pokemon
hclust.pokemon <- hclust(dist(pokemon.scaled), method = "complete")


#### COMPARE K-MEANS AND HCLUST
# Apply cutree() to hclust.pokemon: cut.pokemon
cut.pokemon <- cutree(hclust.pokemon, k = 3)

# Compare methods
km.pokemon <- kmeans(pokemon, centers = 3, nstart = 20, iter.max = 50)
table(cut.pokemon, km.pokemon$cluster)
# => hierarchical clustering model assigns most of the observations to cluster 1, while the k-means algorithm distributes the observations relatively evenly among all clusters.
