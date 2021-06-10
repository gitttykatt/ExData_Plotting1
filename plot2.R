## Code for plot 2

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
colnames(hh_p_subset) <- c("date", "time", "global_active_power", "global_reactive_power", "voltage", "global_intensity", "sub_metering_1", "sub_metering_2", "sub_metering_3")

## create a new variable "datetime" which is a combination of date and time
hh_p_subset$datetime <- strptime(paste(hh_p_subset$date, hh_p_subset$time), "%Y-%m-%d %H:%M:%S")

## lineplot global_active_power against datetime
with(hh_p_subset, plot(datetime, global_active_power, type="l", xlab="", ylab="Global Active Power (kilowatts)"))

## export to png and close
dev.copy(png, file="plot2.png", width=480, height=480)
dev.off()



