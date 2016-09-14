
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

##Plot 4
plot4 <- function() {

png("plot4.png", width=480, height=480)
#Creates a matrix of 2 rows and columns for the graphs below
par(mfrow = c(2, 2)) 

#Creates 4 plots and saves it to a png file
plot(reqpower$timestamp, reqpower$Global_active_power, type="l", xlab="", ylab="Global Active Power", cex=0.2)

plot(reqpower$timestamp, reqpower$Voltage, type="l", xlab="datetime", ylab="Voltage")

plot(reqpower$timestamp, reqpower$Sub_metering_1, type="l", ylab="Energy Submetering", xlab="")
lines(reqpower$timestamp, reqpower$Sub_metering_2, type="l", col="red")
lines(reqpower$timestamp, reqpower$Sub_metering_3, type="l", col="blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=, lwd=2.5, col=c("black", "red", "blue"), bty="o")

plot(reqpower$timestamp, reqpower$Global_reactive_power, type="l", xlab="datetime", ylab="Global_reactive_power")
dev.off()
}
plot4()