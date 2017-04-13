# CA2.
# Author: M Dobie
# Date: 12/04/2017
# Description: R code to clean and pre process the NI Crime Data files

# Merge together all 13 NI Crime csv datasets in directory Crimedsn

# save the current working directory
savewd <- getwd()
# Set the working directory to where the csv files are located
setwd("C:\\Users\\L0013\\Source\\Repos\\DataScienceCA2\\CA2\\Crimedsn")
# Read each csv file into a dataframe. Header is set to true to indicate the first line contains the column names
dat1 <- read.csv("2016-01-northern-ireland-street.csv", header = TRUE)
dat2 <- read.csv("2016-02-northern-ireland-street.csv", header = TRUE)
dat3 <- read.csv("2016-03-northern-ireland-street.csv", header = TRUE)
dat4 <- read.csv("2016-04-northern-ireland-street.csv", header = TRUE)
dat5 <- read.csv("2016-05-northern-ireland-street.csv", header = TRUE)
dat6 <- read.csv("2016-06-northern-ireland-street.csv", header = TRUE)
dat7 <- read.csv("2016-07-northern-ireland-street.csv", header = TRUE)
dat8 <- read.csv("2016-08-northern-ireland-street.csv", header = TRUE)
dat9 <- read.csv("2016-09-northern-ireland-street.csv", header = TRUE)
dat10 <- read.csv("2016-10-northern-ireland-street.csv", header = TRUE)
dat11 <- read.csv("2016-11-northern-ireland-street.csv", header = TRUE)
dat12 <- read.csv("2016-12-northern-ireland-street.csv", header = TRUE)
dat13 <- read.csv("2017-01-northern-ireland-street.csv", header = TRUE)

# Merge dataframes into single dataframe using rbind
alldata <- rbind(dat1, dat2, dat3, dat4, dat5, dat6, dat7, dat8, dat9, dat10, dat11, dat12, dat13)

# set the current working directory back to its original state
setwd(savewd)

# Save the alldata dataframe into a csv file
write.csv(alldata, file = "AllNICrimeData.csv")

# Remove attributes: CrimeID, Reported by, Falls within, LSOA code, LSOA name.
head(alldata)
df <- subset(alldata, select = -c(Crime.ID, Reported.by, Falls.within, LSOA.code, LSOA.name, Last.outcome.category, Context))
head(df)

# Replace "On or near " in Location column with nothing
df$Location <- sub("On or near ", "", df$Location, ignore.case = TRUE)
head(df)

# Modify the dataset to contain an attribute for each crime type with summary information per location
library(reshape2)
md <- melt(df, id=c("Location", "Crime.type", "Longitude", "Latitude"))
head(md)
newdf <- dcast(md, Location + Crime.type + Longitude + Latitude ~ variable)
head(newdf)

# Save the dataframe into a csv file
write.csv(newdf, file = "AllNICrimeDataSummary.csv")

# Amalgamate the post code and crime datasets on Location and Town columns
head(postcd)
head(newdf)

# Change the values in the crime summary (newdf) dataframe to upper case to be able to join with the values in the post code dataframe
newdf$Location <- toupper(newdf$Location)
head(newdf)
head(postcd)

# Merge the two dataframes on Location and Primary.Thorfare
combinedf <- merge(postcd, newdf, by.x="Primary.Thorfare", by.y="Location")
head(combinedf)

# Save the dataframe into a csv file
write.csv(combinedf, file = "FinalNICrimeData.csv")