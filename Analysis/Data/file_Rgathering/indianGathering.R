setwd("C:/Users/obihov/Documents/Illinois/GraduateProgramISU/2Semester/IT497PracticalResearch/R/RstudioWorkspace497/497projectRepo/OsemnProject/Analysis/Data/file_Rgathering")
require(httr)
require(httpuv)
require(jsonlite)
# yelp
# substitute your codes for the xxxx's
consumerKey = "jgqw_ZH9fjPoZmvvqWcNaA"
consumerSecret = "nxkGdieAY1LN8Z6KeZukrZRsfjg"
token = "4gMVscnxTU30_tf8xs0YcRN3McHff5oc"
token_secret = "5qF1VnhF10CFh_zPdx_6ga13aOA"



# authorization
myapp = oauth_app("YELP", key=consumerKey, secret=consumerSecret)
sig=sign_oauth1.0(myapp, token=token,token_secret=token_secret)

URL.API <- "http://api.yelp.com/v2/search/?"
limit <- 20
location <- "Chicago"
term <- "indian%restaurant"


# 20 Indian restaurants in Chicago
yelpurl <- paste0(URL.API,"limit=",limit,"&location=",location,"&term=",term)


#convert json dataframe
locationdata=GET(yelpurl, sig) #response
locationdataContent = content(locationdata) #list

#convert list to JSON
jsonLocationdataContent <- toJSON(locationdataContent) #JSON

#convert JSON object back to R list object
locationdataList=fromJSON(jsonLocationdataContent) #list

#convert list into a dataframe holding the values from all columns
#retrieved from the api. https://www.yelp.com/developers/documentation/v2/search_api 
#go to that site to see all the columns returned and their meaning
df <- data.frame(locationdataList) #dataframe
summary(df)


#Select column from your new dataframe
businessRating <- df[,"businesses.rating"] #list
businessName <- df[,"businesses.name"] #list
businessReviewCount <- df[,"businesses.review_count"] #list
businessLocation <- df[,"businesses.location"] #Dataframe, gather dataframe of location
names(businessLocation)
  businessCity <- businessLocation[,"city"] #list
  businessState <- businessLocation[,"state_code"] #list
  businessCountry <- businessLocation[,"country_code"] #list
businessIsClosedStatus <- df[,"businesses.is_closed"] #list
businessIsClaimedStatus <- df[,"businesses.is_claimed"] #list



#convert all list object to json object
library(jsonlite)
businessRatingjson <- toJSON(businessRating, pretty=TRUE) #json
businessNamejson <- toJSON(businessName, pretty=TRUE) #json
businessReviewCountjson <- toJSON(businessReviewCount, pretty=TRUE) #json
businessCityjson <- toJSON(businessCity, pretty=TRUE) #json
businessStatejson <- toJSON(businessState, pretty=TRUE) #json
businessCountryjson <- toJSON(businessCountry, pretty=TRUE) #json
businessIsClosedStatusjson <- toJSON(businessIsClosedStatus, pretty=TRUE) #json
businessIsClaimedStatusjson <- toJSON(businessIsClaimedStatus, pretty=TRUE) #json


#convert json back to R object- matrix
Ratings<- fromJSON(businessRatingjson)#matrix
Name <- fromJSON(businessNamejson) #matrix
Reviews <- fromJSON(businessReviewCountjson) #matrix
City <- fromJSON(businessCityjson) #matrix
State <- fromJSON(businessStatejson) #matrix
Country <- fromJSON(businessCountryjson) #matrix
isClosed <- fromJSON(businessIsClosedStatusjson) #matrix
isClaimed <- fromJSON(businessIsClaimedStatusjson) #matrix


#Switch working directory to where your data will be saved in the Data/file_CSV dir
#create a new data.frame using the matrix objects above
setwd("C:/Users/obihov/Documents/Illinois/GraduateProgramISU/2Semester/IT497PracticalResearch/R/RstudioWorkspace497/497projectRepo/OsemnProject/Analysis/Data/file_CSV")
newCSV.data <- data.frame(Name, Reviews, Ratings, City, State, Country, isClosed, isClaimed) #dataframe


#write / save the dataset in a csv file as Chinese.csv
write.csv(newCSV.data, file="Indian.csv")

#read the csv file
read.csv("Indian.csv")