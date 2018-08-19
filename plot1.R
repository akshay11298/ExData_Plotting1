#load the household_power_consumption data
data <- read.table("household_power_consumption.txt",sep=";", header = T, stringsAsFactors = F)

#convert Date and Time into date time variables
data["Date"]<- as.Date(data$Date,"%d/%m/%Y")
data["Time"] <- format(data$Time, format="%H:%M:%S")

#Subset of the data and remove unneccesary data
subsetData <- subset(data,Date=="2007-02-01" | Date=="2007-02-02")
rm(data)

#convert the Global_active_variable column from factor to numeric
subsetData["Global_active_power"]<-as.numeric(subsetData$Global_active_power)

#plot1.png 
png(filename = "plot1.png",width = 480, height = 480)
hist(subsetData$Global_active_power, col="red",main="Global Active Power", xlab="Global Active Power (kilowatts)")
dev.off()
