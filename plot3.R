## Code for plot 3

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

# plot
# because there is a legend sizing issue, 
# per a post on the discussion forum, 
# using png() unlike the previous plots

png(file = "plot3.png", width = 480, height = 480)

with(hh_p_subset, {
  plot(datetime, Sub_metering_1, col="black", xlab="", ylab="Energy sub metering", type="l")
  lines(datetime, Sub_metering_2, col="red")
  lines(datetime, Sub_metering_3, col="blue")
})

# add legend
legend("topright", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty = c(1,1,1), col=c("black", "red", "blue"))

# close
dev.off()


