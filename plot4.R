source("loadConsumptionData.R")

png(file="plot4.png",width=480,height=480)

par(mfcol=c(2,2),mar=c(4,4,2,2))

plot(cpM$dt, cpM$Global_active_power, ylab = "Global Active Power (kilowatts)", xlab="", type="n")
lines(cpM$dt, cpM$Global_active_power, type='l')

yRange <- max(c(range(cpM$Sub_metering_1), range(cpM$Sub_metering_2), range(cpM$Sub_metering_3)))

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
