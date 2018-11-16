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

