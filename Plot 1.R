
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
unzip ("household_power_consumption.zip", exdir=getwd())
#read the data from the zip file
household<-read.table("household_power_consumption.txt",header = TRUE,sep = ";")
#Convert the date column fromf factor to Date using as.Date
household$Date <- as.Date(household$Date, "%d/%m/%Y")
#Checking if the Date column is now date
str(household)
#Filtering the data based on the date given in the assignment
filteredHouseData <- household[household$Date =="2007-02-01" | household$Date =="2007-02-02" ,]

#using the png as gravice device
png("plot1.png", width=480, height=480)
#using hist to generate the plot as requested
hist(as.numeric(filteredHouseData$Global_active_power),col="red",main = "Global Active Power", xlab = "Global Active Power (kilowatts)")
dev.off()
