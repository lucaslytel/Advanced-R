getwd()
setwd("/Users/llytel/Desktop/R/Advanced R")
getwd()


#basic import: fin <- read.csv("P3-Future-500-The-Dataset.csv")
fin <- read.csv("P3-Future-500-The-Dataset.csv", na.strings = c(""))
str(fin)
head(fin)
summary(fin)

head(fin, 24)

#factors refesher

fin$ID <- factor(fin$ID)

fin$Inception  <- factor(fin$Inception)

str(fin)
summary(fin)


#factor variable trap! 

#Converting into Numerics from Characters
a <- c("12", "13", "14", "12", "12")
typeof(a)
b <- as.numeric(a)
typeof(b)


#Converting into Nuermics For Factors

z <- factor(c("12", "13", "14", "12", "12"))
z
typeof(z)
y <- as.numeric(z)
typeof(y)
y
#----------
summary(z)
z

#correct way 

x <- as.numeric(as.character(z))
x
typeof(x)


#FVT Example

head(fin)
str(fin)
summary(fin)


## fin$Profit <- factor(fin$Profit)


fin$Profit <- as.numeric(fin$Profit)

str(fin)
head(fin)


#sub() and gsub()
?gsub()
?sub()
fin$Expenses <- gsub(" Dollars","",fin$Expenses)
fin$Expenses <- gsub(",","",fin$Expenses)
head(fin)
str(fin)

fin$Revenue <- gsub("\\$","",fin$Revenue) #escape sequence for special character $ 
head(fin)

fin$Revenue <- gsub(",","",fin$Revenue)
str(fin)
#Do the same thing for growth 

fin$Growth <- gsub("\\%","",fin$Growth)
head(fin)
str(fin)

fin$Revenue <- as.numeric(fin$Revenue)
fin$Expenses <- as.numeric(fin$Expenses)
fin$Growth <- as.numeric(fin$Growth)

#Locate Missing Data
#Updated Import: As new NA's
fin <- read.csv("P3-Future-500-The-Dataset.csv", na.strings = c(""))


head(fin, 24)

fin[!complete.cases(fin),]
str(fin)

#Filtering: Using which() for non-missing data

which(fin$Revenue == 9746272,)
fin[fin$Revenue == 9746272,]

?which

#Returns the rows that are true! 
fin[which(fin$Employees == 45),]

a <- c(1,23,143, NA, 67, NA)

is.na(a)
is.na(fin$Expenses)

fin[is.na(fin$Expenses),]

#Make a backup

fin_backup <- fin


fin[!complete.cases(fin),]

fin[is.na(fin),]
fin <- fin[!is.na(fin$Industry),]
head(fin, 25)

#Resetting the Data Frame index


rownames(fin) <- 1:nrow(fin)

#two ways of doing it
rownames(fin) <- NULL

fin[!complete.cases(fin),]

fin[is.na(fin$State) & fin$City == "New York","State"] <- "NY"

fin[is.na(fin$State) & fin$City == "San Francisco", "State"] <- "CA"

#Check work

fin[c(11,377),]

fin[c(82,265),]


#Doing the median to proxy a value into the column

fin[!complete.cases(fin$Employees),]

med_emp_retail <- median(fin[fin$Industry == "Retail","Employees"], na.rm = TRUE)

mean(fin[fin$Industry == "Retail","Employees"], na.rm = TRUE)

#store in a variable
med_emp_retail

#Apply to area with missing values
fin[is.na(fin$Employees) & fin$Industry == "Retail", "Employees"] <- med_emp_retail
#Check
fin[3,]


#Repeat

med_serv <- median(fin[fin$Industry == "Financial Services", "Employees"], na.rm = TRUE)

fin[!complete.cases(fin$Employees),]

median(fin[fin$Industry == "Financial Services", "Employees"], na.rm = TRUE)

med_serv

fin[is.na(fin$Employees) & fin$Industry == "Financial Services", "Employees"] <- med_serv
fin[330,]


fin[!complete.cases(fin),]

#Median Imputation Method for Growth 

fin[!complete.cases(fin),]


med_growth_constr <- median(fin[fin$Industry == "Construction", "Growth"], na.rm = TRUE)
med_growth_constr


fin[is.na(fin$Growth) & fin$Industry == "Construction", "Growth"] <- med_growth_constr
fin[8,]

fin[!complete.cases(fin),]

#Median Imputation Method for Revenue, Expenses, and Profit

med_revenue_constr <- median(fin[fin$Industry == "Construction", "Revenue"], na.rm = T)
med_revenue_constr

fin[is.na(fin$Revenue) & fin$Industry == "Construction", "Revenue"] <- med_revenue_constr

fin[c(8,42),]

(med_exp_constr <- median(fin[fin$Industry == "Construction", "Expenses"], na.rm = T))

fin[is.na(fin$Expenses) & fin$Industry == "Construction", "Expenses"] <- med_exp_constr

fin[!complete.cases(fin),]

(med_profit_constr <- median(fin[fin$Industry == "Construction", "Profit"], na.rm = T))

fin[is.na(fin$Profit) & fin$Industry == "Construction", "Profit"] <- med_profit_constr


fin[15, "Expenses"] <- fin[15, "Revenue"] - fin[15,"Profit"]

fin[15, ]


#Visualizing Results 

library(ggplot2)

p <- ggplot(data = fin)
p
p + geom_point(aes(x = Revenue, y = Expenses, color = Industry, size = Profit))


# A scatterplot that includes industry trends 

d <-  ggplot(data = fin, aes(x = Revenue, y = Expenses,
                   color = Industry))
d + geom_point() + 
  geom_smooth(fill = NA, size = 1.2)


#Box Plot 

f <-  ggplot(data = fin, aes(x = Industry, y = Growth, 
             color = Industry))
f + geom_boxplot(size = 1)

f + geom_jitter() + 
  geom_boxplot(size = 1, alpha = .5, outlier.color = NA)
