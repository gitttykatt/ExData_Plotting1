## Code for plot 4

## download the zip file, unzip and read
url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(url, destfile = "data.zip", method="curl")
unzip(data.zip, exdir = "./")
hh_p_full <- read.delim("/cloud/project/household_power_consumption.txt", skip = 1, sep=";", header = FALSE)

## convert date (V1, character) to date class
hh_p_full$V1 <- as.Date(strptime(hh_p_full$V1, format="%d/%m/%Y"))

## subset the data to necessary 2 days (2007/02/01 & 2007/02/02)
hh_p_subset <- subset(hh_p_full, V1 >= "2007-02-01" & V1 <= "2007-02-02")

## rename the data frame header for clarification
colnames(hh_p_subset) <- c("date", "time", "global_active_power", "global_reactive_power", "voltage", "global_intensity", "Sub_metering_1", "Sub_metering_2", "Sub_metering_3")

## create a new variable "datetime" which is a combination of date and time
hh_p_subset$datetime <- strptime(paste(hh_p_subset$date, hh_p_subset$time), "%Y-%m-%d %H:%M:%S")

## convert submetering 1 and 2 from character to metrics * submetering 3 is already numeric
hh_p_subset$Sub_metering_1 <- as.numeric(hh_p_subset$Sub_metering_1)
hh_p_subset$Sub_metering_2 <- as.numeric(hh_p_subset$Sub_metering_2)

## using the png() function again to avoid the legend issue
png(file = "plot4.png", width = 480, height = 480)

## create canvas for 4 graphs
par(mfrow=c(2,2))

with(hh_p_subset, {
  ## graph 1: global_active_power
  plot(datetime, global_active_power, type="l", xlab="", ylab="Global Active Power")
  ## graph 2: voltage
  plot(datetime, voltage, type = "l", xlab="datetime", ylab="Voltage")
  ## graph 3: submetering
  plot(datetime, Sub_metering_1, col="black", xlab="", ylab="Energy sub metering", type="l")
  lines(datetime, Sub_metering_2, col="red")
  lines(datetime, Sub_metering_3, col="blue")
  legend("topright", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty = 1, col=c("black", "red", "blue"), box.col="transparent")
  ## graph 4: reactive power
  plot(datetime, global_reactive_power, type = "l", xlab="datetime", ylab="Global_reactive_power")

})

## close
dev.off()
