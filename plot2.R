source("loadConsumptionData.R")

png(file="plot2.png",width=480,height=480)

plot(cpM$dt, cpM$Global_active_power, ylab = "Global Active Power (kilowatts)", xlab="", type="n")
lines(cpM$dt, cpM$Global_active_power, type='l')

dev.off()
