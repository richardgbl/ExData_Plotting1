## read data
library("sqldf")
data <- read.csv.sql("R database/household_power_consumption.txt", header = TRUE, sep = ";",
                     sql = "select * from file where Date = '1/2/2007' OR Date = '2/2/2007'")

## convert the Date and Time to date/time classes 
data$Date.Time <- strptime(paste(data$Date, data$Time),  format = "%d/%m/%Y %H:%M:%S")

## set time in English
Sys.setlocale("LC_TIME", "English")

## open PNG device
png("plot1.png", height = 480, width = 480, bg = "transparent")

## create plot
with(data, hist(Global_active_power, main = "Global Active Power",
                col = "red", xlab = "Global Active Power (kilowatts)"))

## close the PNG device
dev.off()