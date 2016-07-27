sourceData <- 'https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip'

baseFileName <- 'household_power_consumption'
zipFile <- paste0(baseFileName, ".zip")
textFile <- paste0(baseFileName, ".txt")

if (!file.exists(zipFile)) {
  download.file(sourceData, zipFile)
  #, method = "wget"
}

if (!file.exists(textFile)) {
  unzip(zipFile)
}

if (!file.exists(textFile)) {
  stop(paste0("Could not get",textFile) )
}

if (!exists("cpM")) {
    
  setClass("myDate")
  setAs("character","myDate", function(from) as.Date(from, format="%d/%m/%Y") )
  
  consumption <- read.table(textFile, header = TRUE, sep = ';', ,na.strings = '?',
                            colClasses = c("myDate", "character", rep("numeric", 7)))
  
  
  
  lowDate <- as.Date("2007-02-01")
  highDate <- as.Date("2007-02-02")
  
  consumptionForPeriod <- filter(consumption, consumption$Date >= lowDate &
                                   consumption$Date <= highDate)
  
  remove(consumption)
  
  cpM <- mutate(consumptionForPeriod, dt = ymd_hms(paste(Date, Time)))
  
  remove(consumptionForPeriod)
}