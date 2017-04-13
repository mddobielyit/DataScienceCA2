# CA2.
# Author: M Dobie
# Date: 12/04/2017
# Description: R code to clean and pre process the NI post code data

# Read in post code csv into dataframe
postcd <- read.csv("NIPostcodes.csv", header = TRUE)
head(postcd)

# Replace empty data with NA
postcd$Organisation.Name[postcd$Organisation.Name == ""] <- NA
postcd$Sub.building.Name[postcd$Sub.building.Name == ""] <- NA
postcd$Building.Name[postcd$Building.Name == ""] <- NA
postcd$Number[postcd$Number == ""] <- NA
postcd$Primary.Thorfare[postcd$Primary.Thorfare == ""] <- NA
postcd$Alt.Thorfare[postcd$Alt.Thorfare == ""] <- NA
postcd$Secondary.Thorfare[postcd$Secondary.Thorfare == ""] <- NA
postcd$Locality[postcd$Locality == ""] <- NA
postcd$Townland[postcd$Townland == ""] <- NA
postcd$Town[postcd$Town == ""] <- NA
head(postcd)

# Move Primary Key column to the start of the data frame
postcd <- postcd[, c(15, 1:14)]
head(postcd)

# Convert the x, y coordinates to longitude and latitude using the rgdal lilbrary
#x <- postcd$x.coordinates
#y <- postcd$y.coordinates

#library(rgdal)
#d <- data.frame(lon = x, lat = y)
#coordinates(d) <- c("lon", "lat")
#proj4string(d) <- CRS("+init=epsg:29902") # WGS 84
#CRS.new <- CRS("+proj=tmerc +lat_0=53.5 +lon_0=-8 +k=1.000035 +x_0=200000 +y_0=250000 +a=6377340.189 +b=6356034.447938534 +units=m +no_defs")
