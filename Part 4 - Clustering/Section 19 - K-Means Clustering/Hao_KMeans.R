#K-Means Clustering

#Importing the DataSet
dataset = read.csv("Mall_Customers.csv")
X = dataset[4:5]

#Using the Elbow Method to find the optimal number of clusters
set.seed(6)
mcss = vector()
for (i in 1:10) mcss[i] = kmeans(X,i)$tot.withinss
plot(1:10,
     mcss,
     type = 'b',
     main = 'The Albow Method',
     xlab = 'Number of Clusters',
     ylab = 'mcss')
     
#As we can see from the plot, the elbow point is 5

#Fitting the K-Means to the dataset
Kmeans = kmeans(X, 5, iter.max = 300, nstart = 10)
y_Kmeans = Kmeans$cluster

#Visualizing the Clusters
#library('cluster')
clusplot(X,
         y_Kmeans,
         main = 'K-Means Clusters',
         lines = 0,
         shade = TRUE,
         color = TRUE,
         labels = 2,
         #每个cluster是不是表示方式一样
         plotchar = FALSE,
         span = TRUE,
         xlab = 'Annual Income',
         ylab = 'Shopping Score')
