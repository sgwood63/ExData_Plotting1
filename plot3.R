source("loadConsumptionData.R")

png(file="plot3.png",width=480,height=480)

yRange <- max(c(range(cpM$Sub_metering_1), range(cpM$Sub_metering_2), 
                range(cpM$Sub_metering_3)))

plot(range(cpM$dt), c(0, yRange), ylab = "Energy sub metering", xlab="",
     type="n")
lines(cpM$dt, cpM$Sub_metering_1, col='black')
lines(cpM$dt, cpM$Sub_metering_2, col='red')
lines(cpM$dt, cpM$Sub_metering_3, col='blue')
legend("topright", lwd=1, lty=1,  
       col=c("black","red", "blue"), 
       legend=c("Sub_metering_1","Sub_metering_2", "Sub_metering_3"))

dev.off()
