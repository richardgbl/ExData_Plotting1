## read data
library("sqldf")
data <- read.csv.sql("R database/household_power_consumption.txt", header = TRUE, sep = ";",
                     sql = "select * from file where Date = '1/2/2007' OR Date = '2/2/2007'")

## convert the Date and Time to date/time classes 
data$Date.Time <- strptime(paste(data$Date, data$Time),  format = "%d/%m/%Y %H:%M:%S")

## set time in English
Sys.setlocale("LC_TIME", "English")

## open PNG device
png("plot4.png", height = 480, width = 480, bg = "transparent")

## set 2 x 2 pictures on one plot 
par(mfrow = c(2, 2))

## create the first plot
with(data, plot(Date.Time, Global_active_power, xlab = "", ylab = "Global Active Power", type = "l"))

## create the second plot
with(data, plot(Date.Time, Voltage, xlab = "datetime", ylab = "Voltage", type = "l"))

## create the third plot
with(data, plot(Date.Time, Sub_metering_1, xlab = "", ylab = "Energy sub metering", type = "l"))
with(data, lines(Date.Time, Sub_metering_2, col = "red"))
with(data, lines(Date.Time, Sub_metering_3, col = "blue"))
legend("topright", legend = names(data[, 7:9]), lty = c("solid", "solid", "solid"), col = c("black", "red", "blue"), bty = "n")

## create the forth plot
with(data, plot(Date.Time, Global_reactive_power, xlab = "datetime", type = "l"))

## close PNG device
dev.off()