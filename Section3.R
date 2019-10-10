getwd()
setwd("/Users/llytel/Desktop/R/Advanced R")
util <- read.csv("P3-Machine-Utilization.csv")

head(util, 12)
str(util)
summary(util)

#Dervie utilization

util$Utilization = 1 - util$Percent.Idle
head(util,12)
summary(util)

#Handeling Dates and Times in R
?POSIXct
util$PosixTime <- as.POSIXct(util$Timestamp, format = "%d/%m/%Y %H:%M")
head(util,12)


#tip how to rearrange columns in a data frame

util$Timestamp <- NULL

util <- util[,c(4,1,2,3)]


#What is a list? - Like a vector but can contain many different types! 

summary(util)

RL1 <- util[util$Machine == "RL1",]
summary(RL1)
RL1$Machine <- factor(RL1$Machine)

#Construct List 
#Character: Machine Name
#Vector: (min, mean, max) utilzation for that month (excluding unknown hours)
#Logical: Has utlization gone below 90% TRUE/FALSE

util_stats_rl1 <- c(min(RL1$Utilization, na.rm = T), 
                    mean(RL1$Utilization, na.rm = T),
                    max(RL1$Utilization, na.rm = T))
util_stats_rl1

RL1$Utilization

#Ignores NA's and returns the indicies where condition is true
rm(util_under_90)
util_under_90_flag <- length(which(RL1$Utilization < 0.90)) > 0
util_under_90_flag

list_rl1 <- list(Machine="RL1", Stats=util_stats_rl1, LowThreshold=util_under_90_flag)

list_rl1

#Two ways of assigning names! 
names(list_rl1) <- c("Machine", "Stats", "LowThreshold")

list_rl1


#Three ways of extracting components from a list! 
#[] - this will always return a list
#[[]] - this will always return the object inside the list 
#$ - same as [[]] but prettier

list_rl1[1]

list_rl1[[1]]

list_rl1$Machine


list_rl1[2]
typeof(list_rl1[2])


list_rl1[[2]]
typeof(list_rl1[[2]])


list_rl1$Stats[3]

list_rl1$LowThreshold


#adding and deleting from a list 

list_rl1[100] <- "Test" #When you add something to a higher index the ones in between become NULL's
list_rl1

#add in via the $ operator 

list_rl1$UnknownHours <- RL1[is.na(RL1$Utilization), "PosixTime"]
list_rl1[5:100] <- NULL

#Numeration has shifted! 

list_rl1$Data <- RL1
list_rl1

summary(list_rl1)

#Subsetting a list! 

list_rl1$UnknownHours[1]
list_rl1[[4]][1]

list_rl1[1]
list_rl1[1:3]
list_rl1[c(1,4)]

library(ggplot2)
p <- ggplot(data = util)
p + geom_line(aes(x = PosixTime, y = Utilization,
                  color = Machine), size = 1.2) +
  facet_grid(Machine~.) +
  geom_hline(yintercept = 0.9, color = "Gray",
             size = 1.2, linetype = 3)

myplot <- p + geom_line(aes(x = PosixTime, y = Utilization,
                            color = Machine), size = 1.2) +
  facet_grid(Machine~.) +
  geom_hline(yintercept = 0.9, color = "Gray",
             size = 1.2, linetype = 3)


myplot

list_rl1$Plot <- myplot
list_rl1
str(list_rl1)




