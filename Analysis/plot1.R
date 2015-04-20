setwd("C:/Users/obihov/Documents/Illinois/GraduateProgramISU/2Semester/IT497PracticalResearch/R/RstudioWorkspace497/497projectRepo/OsemnProject/Analysis")
##############INDIAN#################
#Read in the data
myIndianData <- read.csv("Data/file_CSV/Indian.csv")
head(myIndianData)
class(myIndianData$isClaimed)
names(myIndianData)



#Reshape dataframe variables
str(myIndianData) #variable type details
myIndianData$Name <- as.character(myIndianData$Name)
myIndianData$City <- as.character(myIndianData$City)
myIndianData$State <- as.character(myIndianData$State)
myIndianData$Country <- as.character(myIndianData$Country)
myIndianData$isClosed <- as.character(myIndianData$isClosed)
myIndianData$isClaimed <- as.character(myIndianData$isClaimed)
myIndianData$Ratings <- as.numeric(myIndianData$Ratings)
myIndianData$Reviews <- as.numeric(myIndianData$Reviews)
str(myIndianData) #confirm variable type details have been properly formatted



#Use grep to eliminate / select rows that are only required
myIndianData_City.gr <- myIndianData[grep("Chicago", myIndianData$City),]
  dim(myIndianData_City.gr) #three dataset having "La Grange, Oak Park" are elimanted
myIndianData_isClosed.gr <- myIndianData_City.gr[grep("FALSE", myIndianData_City.gr$isClosed),]
  dim(myIndianData_isClosed.gr) #all businesses included here are opened
myIndianData_isClaimed.gr <- myIndianData_isClosed.gr[grep("TRUE", myIndianData_isClosed.gr$isClaimed),]
  dim(myIndianData_isClaimed.gr)



#############CHINESE#####################
#Read in the data
myChineseData <- read.csv("Data/file_CSV/Chinese.csv")
head(myChineseData)
class(myChineseData$isClaimed)
names(myChineseData)



#Reshape dataframe variables
str(myChineseData) #variable type details
myChineseData$Name <- as.character(myChineseData$Name)
myChineseData$City <- as.character(myChineseData$City)
myChineseData$State <- as.character(myChineseData$State)
myChineseData$Country <- as.character(myChineseData$Country)
myChineseData$isClosed <- as.character(myChineseData$isClosed)
myChineseData$isClaimed <- as.character(myChineseData$isClaimed)
myChineseData$Ratings <- as.numeric(myChineseData$Ratings)
myChineseData$Reviews <- as.numeric(myChineseData$Reviews)
str(myChineseData) #confirm variable type details have been properly formatted


#Use grep to eliminate / select rows that are only required
myChineseData_City.gr <- myChineseData[grep("Chicago", myChineseData$City),]
  dim(myChineseData_City.gr) #Businesses in Chicago only
myChineseData_isClosed.gr <- myChineseData_City.gr[grep("FALSE", myChineseData_City.gr$isClosed),]
  dim(myChineseData_isClosed.gr) #all businesses included here are opened
myChineseData_isClaimed.gr <- myChineseData_isClosed.gr[grep("TRUE", myChineseData_isClosed.gr$isClaimed),]
  dim(myChineseData_isClaimed.gr) #Businesses here are all claimed by a owner


#Now that we have our data (i.e. myIndianData_isClaimed.gr and myChineseData_isClaimed.gr)
#All we need to do now is, extract a subset of the dataset we want to work with
#This will serve as our criteria that will help us come up with an objective research finding
#We will select only observations where Reviews are between 100 and 899
#Use subset to create this rule
names(myChineseData_isClaimed.gr)
myChinese.subset <- subset(myChineseData_isClaimed.gr, Reviews >= 100 & Reviews <= 899)
  dim(myChinese.subset)
myIndian.subset <- subset(myIndianData_isClaimed.gr, Reviews >= 100 & Reviews <= 899)
  dim(myIndian.subset)
names(myChinese.subset)

#We have just achieved a cleaned version of our data. We shall execute the following commands.
#CHINESE
names(myChinese.subset)
class(myChinese.subset$Name)
class(myChinese.subset$Reviews)
class(myChinese.subset$Ratings)
class(myChinese.subset$City)
class(myChinese.subset$State)
class(myChinese.subset$Country)
class(myChinese.subset$isClosed)
class(myChinese.subset$isClaimed)
class(myChinese.subset)
summary(myChinese.subset)
str(myChinese.subset)

#INDIAN
names(myIndian.subset)
class(myIndian.subset$Name)
class(myIndian.subset$Reviews)
class(myIndian.subset$Ratings)
class(myIndian.subset$City)
class(myIndian.subset$State)
class(myIndian.subset$Country)
class(myIndian.subset$isClosed)
class(myIndian.subset$isClaimed)
class(myIndian.subset)
summary(myIndian.subset)
str(myIndian.subset)

#Now we simply select the columns we want to work with.
#Select the Name and Ratings column from the myChinese.subset and myIndian.subset dataframe
myChinese.selection <- data.frame(myChinese.subset$Name, myChinese.subset$Ratings)
myIndian.selection <- data.frame(myIndian.subset$Name, myIndian.subset$Ratings)


#Now we simply rename our variable names
library(plyr)
myChinese.New <- rename(myChinese.selection, replace=c("myChinese.subset.Name"="Name", "myChinese.subset.Ratings"="Ratings"))
  names(myChinese.New)
myIndian.New <- rename(myIndian.selection, replace=c("myIndian.subset.Name"="Name", "myIndian.subset.Ratings"="Ratings"))
  names(myIndian.New)

myChinese.New$Name <- as.character(myChinese.New$Name)
myIndian.New$Name <- as.character(myIndian.New$Name)

#Chinese table
#myChinese.New[,"Name"]
#myChinese.New[,"Ratings"]

#Now we calculate average rating for each of the restaurant.
#The average / mean rating will help us determine what restaurants type is likely to have wi-fi
#From our hypothesis, Restaurants with high rating is likely to have wi-fi
averageChinese <- mean(myChinese.New$Ratings)
averageIndian <- mean(myIndian.New$Ratings)
averagesVect <- c(averageIndian, averageChinese)
nameVect <- c("Indian", "Chinese")
avgMAT <- cbind(nameVect, averagesVect)
avgDF <- as.data.frame(avgMAT)
names(avgDF) <- c("Restaurant Type", "Average")

#format col data type
avgDF[,"Restaurant Type"] <- as.character(avgDF[,"Restaurant Type"])
avgDF[,"Average"] <- as.numeric(as.character(avgDF[,"Average"]))
class(avgDF[,"Average"])

#for the graph use
catIndian <- avgDF[1,1]
catChinese <- avgDF[2,1]
avgIndian <- avgDF[1,2]
avgChinese <- avgDF[2,2]

library(ggplot2)
categoryRestaurant <- factor(c(catIndian,catChinese), levels=c("Indian","Chinese"))
dat <- data.frame(category = categoryRestaurant, average = c(avgIndian, avgChinese))

ggplot(data=dat, aes(x=category, y=average, fill=category)) +
  geom_bar(stat="identity")

ggplot(data=dat, aes(x=category, y=average, group=1)) +
  geom_line(colour="red", linetype="dashed", size=1.5) +
  geom_point(colour="red", size=4, shape=21, fill="white")


#for the table. you can also add the myChinese.New and myIndian.New in order to plot their tables
knitr::kable(avgDF, digits = 2, caption = "A table")
#Using a nominal scale we can even go as far as to relating our finding
#1- very unlikely
#2- unlikely
#3- moderate
#4- likely
#5- very likely
#Now we can see that both restuarants fall within 3 and 4. Approximately, both are likely to have
#wi-fi
