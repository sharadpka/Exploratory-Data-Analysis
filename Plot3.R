
##Reads and loads the file to a table
dataFile <- "household_power_consumption.txt"
power <- read.table(dataFile, header=TRUE, sep=";", stringsAsFactors=FALSE, dec=".")

##Reads and processes the variables
power$Date <- as.Date(power$Date, format="%d/%m/%Y")
reqpower <- power[(power$Date=="2007-02-01") | (power$Date=="2007-02-02"),]
reqpower$Global_active_power <- as.numeric(as.character(reqpower$Global_active_power))
reqpower$Global_reactive_power <- as.numeric(as.character(reqpower$Global_reactive_power))
reqpower$Voltage <- as.numeric(as.character(reqpower$Voltage))
reqpower <- transform(reqpower, timestamp=as.POSIXct(paste(Date, Time)), "%d/%m/%Y %H:%M:%S")
reqpower$Sub_metering_1 <- as.numeric(as.character(reqpower$Sub_metering_1))
reqpower$Sub_metering_2 <- as.numeric(as.character(reqpower$Sub_metering_2))
reqpower$Sub_metering_3 <- as.numeric(as.character(reqpower$Sub_metering_3))

##Plot 3
#Creates plot of date/time v Sub metering 1 data and saves it to a png file
plot3 <- function() {
  png("plot3.png", width=480, height=480)
  plot(reqpower$timestamp, reqpower$Sub_metering_1, type="l", ylab="Energy sub metering", xlab="")
  
  #Adds line graph for date/time v Sub metering 2 data in red
  lines(reqpower$timestamp, reqpower$Sub_metering_2, type="l", col = "red" )
  
  #Adds line graph for date/time v Sub metering 3 data in blue
  lines(reqpower$timestamp, reqpower$Sub_metering_3, type = "l", col = "blue" )
  
  #Adds legend to graph
  legend("topright", lty= 1, col = c("Black", "red", "blue"), legend = c( "Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
  dev.off()
}
plot3()