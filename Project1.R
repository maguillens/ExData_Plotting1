setwd("C:/Users/MIGUEL GUILLEN/Documents/GitHub/ExData_Plotting1/Project1")

hpc <- read.table("household_power_consumption.txt", header=TRUE, sep=";", na.strings = "?", colClasses = c('character','character','numeric','numeric','numeric','numeric','numeric','numeric','numeric'))

## Format date to Type Date
hpc$Date <- as.Date(hpc$Date, "%d/%m/%Y")

## Filter data set from Feb. 1, 2007 to Feb. 2, 2007
hpc <- subset(hpc,Date >= as.Date("2007-2-1") & Date <= as.Date("2007-2-2"))

## Remove incomplete observation
hpc <- hpc[complete.cases(hpc),]

## Combine Date and Time column
dateTime <- paste(hpc$Date, hpc$Time)

## Name the vector
dateTime <- setNames(dateTime, "DateTime")

## Remove Date and Time column
hpc <- hpc[ ,!(names(hpc) %in% c("Date","Time"))]

## Add DateTime column
hpc <- cbind(dateTime, hpc)

## Format dateTime Column
hpc$dateTime <- as.POSIXct(dateTime)


## Create Plot 1
dev.copy(png,"plot1.png", width=480, height=480)
hist(hpc$Global_active_power, main="Global Active Power", xlab = "Global Active Power (kilowatts)", col="red")
dev.off()

## Create Plot 2
dev.copy(png,"plot2.png", width=480, height=480)
plot(hpc$Global_active_power~hpc$dateTime, type="l", ylab="Global Active Power (kilowatts)", xlab="")
dev.off()

## Create Plot 3
dev.copy(png,"plot3.png", width=480, height=480)
with(hpc, {
  plot(Sub_metering_1~dateTime, type="l",
       ylab="Global Active Power (kilowatts)", xlab="")
  lines(Sub_metering_2~dateTime,col='Red')
  lines(Sub_metering_3~dateTime,col='Blue')
})
legend("topright", col=c("black", "red", "blue"), lwd=c(1,1,1), 
       c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
dev.off()

## Create Plot 4
dev.copy(png,"plot4.png", width=480, height=480)
par(mfrow=c(2,2), mar=c(4,4,2,1), oma=c(0,0,2,0))
with(hpc, {
  plot(Global_active_power~dateTime, type="l", 
       ylab="Global Active Power (kilowatts)", xlab="")
  plot(Voltage~dateTime, type="l", 
       ylab="Voltage (volt)", xlab="")
  plot(Sub_metering_1~dateTime, type="l", 
       ylab="Global Active Power (kilowatts)", xlab="")
  lines(Sub_metering_2~dateTime,col='Red')
  lines(Sub_metering_3~dateTime,col='Blue')
  legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, bty="n",
         legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
  plot(Global_reactive_power~dateTime, type="l", 
       ylab="Global Rective Power (kilowatts)",xlab="")
})
dev.off()
