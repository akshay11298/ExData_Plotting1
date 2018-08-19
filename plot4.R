#load the household_power_consumption data
data <- read.table("household_power_consumption.txt",sep=";", header = T, stringsAsFactors = F)

#complete time
dateTime <- strptime(paste(data$Date,data$Time,sep = " "),"%d/%m/%Y %H:%M:%S")
data<-cbind(data,dateTime)

#convert data$Date and data$Time into date time variables
data["Date"] <- as.Date(data$Date,"%d/%m/%Y")
data["Time"] <- format(data$Time, format="%H:%M:%S")

#Subset of the data and remove unneccesary data
subsetData <- subset(data,Date=="2007-02-01" | Date=="2007-02-02")
rm(data)

#cast the required variables
subsetData["Global_active_power"]<-as.numeric(subsetData$Global_active_power)
subsetData$Voltage <- as.numeric(subsetData$Voltage)
subsetData$Global_reactive_power <- as.numeric(subsetData$Global_reactive_power)
subsetData$Sub_metering_1 <- as.numeric(subsetData$Sub_metering_1)
subsetData$Sub_metering_2 <- as.numeric(subsetData$Sub_metering_2)
subsetData$Sub_metering_3 <- as.numeric(subsetData$Sub_metering_3)

#plot4.png
png(filename = "plot4.png",width = 480, height = 480)
par(mfrow=c(2,2))
with(subsetData,plot(dateTime,Global_active_power,ylab = "Global Active Power", xlab = "",type = "l"))
with(subsetData,plot(dateTime,Voltage, type = "l"))
with(subsetData, plot(dateTime,Sub_metering_1,type = "l",xlab = "",ylab = "Energy Sub Metering"))
with(subsetData,lines(dateTime,Sub_metering_2,col="red"))
with(subsetData,lines(dateTime,Sub_metering_3,col="blue"))
legend("topright",c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),col = c("black","red","blue"),lty = 1,lwd = 2,bty="n")
with(subsetData,plot(dateTime,Global_reactive_power, type = "l"))
dev.off()
