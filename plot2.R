#if file does not exist, download it
if(!file.exists("household_power_consumption.txt"))
{
  data_url<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
  download.file(data_url,"household_power_consumption.zip")
  unzip("household_power_consumption.zip")
}

#load the household_power_consumption data
data <- read.table("household_power_consumption.txt",sep=";", header = T, stringsAsFactors = F)

#complete time
dateTime <- strptime(paste(data$Date,data$Time,sep = " "),"%d/%m/%Y %H:%M:%S")
data<-cbind(data,dateTime)

#convert data$Date and data$Time into date time variables
data["Date"]<- as.Date(data$Date,"%d/%m/%Y")
data["Time"] <- format(data$Time, format="%H:%M:%S")

#Subset of the data and remove unneccesary data
subsetData <- subset(data,Date=="2007-02-01" | Date=="2007-02-02")
rm(data)

#convert the Global_active_variable column from factor to numeric
subsetData["Global_active_power"]<-as.numeric(subsetData$Global_active_power)

#plot2.png
png(filename = "plot2.png",width = 480, height = 480)
with(subsetData, plot(dateTime,Global_active_power,ylab = "Global Active Power",type = "l"))
dev.off()
