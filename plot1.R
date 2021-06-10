## Code for plot 1

## download the zip file, unzip and read
url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(url, destfile = "data.zip", method="curl")
unzip(data.zip, exdir = "./")
hh_p_full <- read.delim("/cloud/project/household_power_consumption.txt", skip = 1, sep=";", header = FALSE)

## quick check of the loaded data
# head(hh_p_full)
# class(hh_p_full$V1)

## convert date (V1, character) to date class
hh_p_full$V1 <- as.Date(strptime(hh_p_full$V1, format="%d/%m/%Y"))

## quick check of the result of the above date conversion
# head(hh_p_full)
# str(hh_p_full)

## subset the data to necessary 2 days (2007/02/01 & 2007/02/02)
hh_p_subset <- subset(hh_p_full, V1 >= "2007-02-01" & V1 <= "2007-02-02")

## rename the data frame header for clarification
colnames(hh_p_subset) <- c("date", "time", "global_active_power", "global_reactive_power", "voltage", "global_intensity", "sub_metering_1", "sub_metering_2", "sub_metering_3")

## change the class of "global_active_power" from character to numeric
hh_p_subset$global_active_power <- as.numeric(hh_p_subset$global_active_power)

## plot
with(hh_p_subset, hist(global_active_power, xlab="Global Active Power (kilowatts)", ylab="Frequency", main = "Global Active Power", col="red"))

## export to png and close
dev.copy(png, file="plot1.png", width=480, height=480)
dev.off()

