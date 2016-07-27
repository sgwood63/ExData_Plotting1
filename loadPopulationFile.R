# load the data for the exercise

sourceData <- 'https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip'

baseFileName <- 'household_power_consumption'
zipFile <- paste0(baseFileName, ".zip")
textFile <- paste0(baseFileName, ".txt")

# contains household_power_consumption.txt

# Description:
# Measurements of electric power consumption in one household with a 
# one-minute sampling rate over a period of almost 4 years. Different electrical 
# quantities and some sub-metering values are available.

library(sqldf) 

if (!file.exists(zipFile)) {
  download.file(sourceData, zipFile, method = "wget")
}

if (!file.exists(textFile)) {
  unzip(zipFile)
}

if (!file.exists(textFile)) {
  break
}

setClass("myDate")
#setClass("myTime")
#setAs("character","myTime", function(from) hms(from) )
setAs("character","myDate", function(from) as.Date(from, format="%d/%m/%Y") )
#setAs("character","myDate", function(from) dmy(from) )

#setClass("myAmount")
#setAs("character","myAmount", function(from) ifelse (from == '?',NULL,as.numeric(from)))

# define wp as a file with indicated format 
#consumpFile <- file(textFile) 
#attr(consumpFile, "file.format") <- list(header = TRUE, sep = ';', , na.strings = '?',
#                                colClasses = c("myDate", "myTime", rep("numeric", 7)))

consumption <- read.table(textFile, header = TRUE, sep = ';', ,na.strings = '?',
                          colClasses = c("myDate", "character", rep("numeric", 7)))



lowDate <- as.Date("2007-02-01")
highDate <- as.Date("2007-02-02")

consumptionForPeriod <- filter(consumption, consumption$Date >= lowDate &
                               consumption$Date <= highDate)
#consump.df <-read.csv.sql(textFile,
#             sql= "select * from consumpFile where Date between '2007-02-01' and '2007-02-02'",
#             header = TRUE, sep = ';', 
#             colClasses = c("myDate", "myTime", rep("myAmount", 7)))

# use sqldf to read it in keeping only indicated rows 
#consump.df <- sqldf("select * from consumpFile where Date between '2007-02-01' and '2007-02-02'") 

# fix up type of value__1 
#consump.df$value__1 <- as.numeric(as.character(consump.df$value__1)) 

png(file="plot1.png",width=480,height=480)

hist(consumptionForPeriod$Global_active_power, col="red", main="Global Active Power", xlab="Global Active Power (kilowatts)")

dev.off()

cpM <- mutate(consumptionForPeriod, dt = ymd_hms(paste(Date, Time)))

png(file="plot2.png",width=480,height=480)

plot(cpM$dt, cpM$Global_active_power, ylab = "Global Active Power (kilowatts)", xlab="", type="n")
lines(cpM$dt, cpM$Global_active_power, type='l')

dev.off()

png(file="plot3.png",width=480,height=480)

yRange <- max(c(range(cpM$Sub_metering_1), range(cpM$Sub_metering_2), range(cpM$Sub_metering_3)))


plot(range(cpM$dt), c(0, yRange), ylab = "Energy sub metering", xlab="", type="n")
lines(cpM$dt, cpM$Sub_metering_1, col='black')
lines(cpM$dt, cpM$Sub_metering_2, col='red')
lines(cpM$dt, cpM$Sub_metering_3, col='blue')
legend("topright", lwd=1, lty=1,  
       col=c("black","red", "blue"), legend=c("Sub_metering_1","Sub_metering_2", "Sub_metering_3"))

dev.off()


png(file="plot4.png",width=480,height=480)

par(mfcol=c(2,2),mar=c(4,4,2,2))

plot(cpM$dt, cpM$Global_active_power, ylab = "Global Active Power (kilowatts)", xlab="", type="n")
lines(cpM$dt, cpM$Global_active_power, type='l')

plot(range(cpM$dt), c(0, yRange), ylab = "Energy sub metering", xlab="", type="n")
lines(cpM$dt, cpM$Sub_metering_1, col='black')
lines(cpM$dt, cpM$Sub_metering_2, col='red')
lines(cpM$dt, cpM$Sub_metering_3, col='blue')
legend("topright", lwd=1, lty=1, bty="n",
       col=c("black","red", "blue"), legend=c("Sub_metering_1","Sub_metering_2", "Sub_metering_3"))

plot(cpM$dt, cpM$Voltage, xlab="datetime", ylab="Voltage", type="n")
lines(cpM$dt, cpM$Voltage, type='l')

plot(cpM$dt, cpM$Global_reactive_power, ylab = "Global_reactive_power", xlab="datetime", type="n")
lines(cpM$dt, cpM$Global_reactive_power, type='l')

dev.off()

plot(range(cpM$dt), cpM$Global_active_power, ylab = "Global Active Power (kilowatts)", xlab="", type="n")

