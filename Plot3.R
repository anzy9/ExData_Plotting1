
mainDir<-getwd()
subDir<-"Course4Assignment1"
if (file.exists(subDir)){
  setwd(file.path(mainDir, subDir))
} else {
  dir.create(file.path(mainDir, subDir))
  setwd(file.path(mainDir, subDir))
  
}
#download the file and unzip into created folder
mDir<-paste(getwd(),"/household_power_consumption.zip",sep = "")
url<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
if (!file.exists(mDir)){
  download.file(url, dest="household_power_consumption.zip", mode="wb") 
}
library(dplyr)
unzip ("household_power_consumption.zip", exdir=getwd())
#read the data from the zip file
household<-read.table("household_power_consumption.txt", header=TRUE, na.strings="?", sep=";")
dt<-tbl_df(household)
filteredHouseData <- filter(dt,Date %in% c("1/2/2007","2/2/2007"))

#Combing the Date and Time using paste function and the using the Strptime to convert it  D M Y H M S format
filteredHouseData$DateTime<-strptime(paste(filteredHouseData$Date,filteredHouseData$Time,sep= " "),"%d/%m/%Y %H:%M:%S")

png("plot3.png", width=480, height=480)

plot(filteredHouseData$DateTime,filteredHouseData$Sub_metering_1,col="grey",type = "l",xlab="",ylab = "Energy Sub metering")
lines(filteredHouseData$DateTime,filteredHouseData$Sub_metering_2,col="red")
lines(filteredHouseData$DateTime,filteredHouseData$Sub_metering_3,col="blue")
legend('topright', legend=c('Sub_metering_1', 'Sub_metering_2', 'Sub_metering_3'), lwd='1', col=c('grey', 'red', 'blue'))

dev.off()

