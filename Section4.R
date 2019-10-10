#Section 4 

getwd()

setwd("./Weather Data")

Chicago <- read.csv("Chicago-F.csv", row.names = 1)
Houston <- read.csv("Houston-F.csv", row.names = 1)
NewYork <- read.csv("NewYork-F.csv", row.names = 1)
SanFrancisco <- read.csv("SanFrancisco-F.csv", row.names = 1)

#Check
Chicago
Houston
NewYork
SanFrancisco

is.data.frame(Chicago)
#Convert to Maricies

Chicago <- as.matrix(Chicago)
NewYork <- as.matrix(NewYork)
Houston <- as.matrix(Houston)
SanFrancisco <- as.matrix(SanFrancisco)

#Put them into a list 

Weather <- list(Chicago = Chicago, NewYork = NewYork, Houston = Houston, SanFrancisco = SanFrancisco)

Weather[3]
typeof(Weather[[3]])


#using apply

?apply
Chicago

apply(Chicago, 1, mean)
apply(Chicago, 1, max)
apply(Chicago, 1, min)

#means for all cities
apply(Chicago, 1, mean)
apply(Houston, 1, mean)
apply(NewYork, 1, mean)
apply(SanFrancisco, 1, mean)


#Find the means of every row 
#1. Via Loops

output <- NULL
for(i in 1:5) {
  output[i] <- mean(Chicago[i,])
}

output
names(output) <- rownames(Chicago)


#2. Apply function 

apply(Chicago, 1, mean)


#lapply - apply a function over a list or vector and returns a list! 

lapply(Weather, t) #list(t(Weather$Chicago), t(Weather$NewYork), t(Weather$Houston), t(Weather$SanFransisco))

mynewlist <- lapply(Weather, t)

#Example 2
Chicago
rbind(Chicago, NewRow=1:12)
lapply(Weather, rbind, NewRow=1:12)

#Example 3

?rowMeans
lapply(Weather, rowMeans)


#rowMeans
#colMeans
#rowSums
#colSums


#Combining lapply with th [ ] operator

Weather
Weather[[1]][1,1]
lapply(Weather, "[", 1, 1)


#lapply(Weather, "[", , 3)


#Adding custom fuctions

lapply(Weather, function(x) x[1, ])
lapply(Weather, function(x) x[5, ])
lapply(Weather, function(x) x[,12])
lapply(Weather, function(z) round((z[1,] - z[2,]) / z[2,], 2))

?sapply

lapply(Weather, "[", 1, 7)
sapply(Weather, "[", 1, 7)


lapply(Weather, "[", 1, 10:12)
sapply(Weather, "[", 1, 10:12)

lapply(Weather, rowMeans)
round(sapply(Weather, rowMeans),2) 


lapply(Weather, function(z) round((z[1,] - z[2,]) / z[2,], 2))
sapply(Weather, function(z) round((z[1,] - z[2,]) / z[2,], 2))


lapply(Weather, rowMeans)
Chicago


apply(Chicago, 1, max)


lapply(Weather, apply, 1, max)
sapply(Weather, apply, 1, max)
sapply(Weather, apply, 1, min)


#Very advanced tutorials
#which.max 

?which.max
Chicago
names(which.max(Chicago[1,]))

#Nesting applies inside other applies
apply(Chicago, 1, function(x) names(which.max(x)))

lapply(Weather, apply, 1, function(x) names(which.max(x)))

lapply(Weather, function(y) apply(y, 1, function(x) names(which.max(x))))




