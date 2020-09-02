library("data.table")
Sys.setenv("LANGUAGE"="En")
Sys.setlocale("LC_ALL", "English")

# read data from text file
data <- fread("household_power_consumption.txt", na.strings="?")

# filter data and modify date variables
data <- data[data$Date=="1/2/2007" | data$Date=="2/2/2007", ]
data$cDate <- paste(data$Date, data$Time)
data$cDate <- as.POSIXct(strptime(data$cDate, format = "%d/%m/%Y %H:%M:%S", tz = "Europe/London"))

# set device to png and format of subplots
png(filename = "plot4.png", width = 480, height = 480)
par(mfcol = c(2,2))

# subplot 1
plot(data$cDate, data$Global_active_power, xlab = "", ylab = "Global Active Power", type = "n")
lines(data$cDate, data$Global_active_power)

# subplot 2
plot(data$cDate, data$Global_active_power, xlab = "", ylab = "Energy sub metering", type = "n", ylim = c(0,  40))
with(data, lines(cDate, Sub_metering_1, col="black"))
with(data, lines(cDate, Sub_metering_2, col="red"))
with(data, lines(cDate, Sub_metering_3, col="blue"))
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col=c("black", "red", "blue"), lty = 1)

# subplot 3
plot(data$cDate, data$Voltage, xlab = "datetime", ylab = "Voltage", type = "n")
lines(data$cDate, data$Voltage)

# subplot 4
plot(data$cDate, data$Global_reactive_power, xlab = "datetime", ylab = "Global_reactive_power", type = "n")
lines(data$cDate, data$Global_reactive_power)

# close device
dev.off()