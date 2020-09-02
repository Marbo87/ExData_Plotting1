library("data.table")
Sys.setenv("LANGUAGE"="En")
Sys.setlocale("LC_ALL", "English")

# read data from text file
data <- fread("household_power_consumption.txt", na.strings="?")

# filter data and modify date variables
data <- data[data$Date=="1/2/2007" | data$Date=="2/2/2007", ]
data$cDate <- paste(data$Date, data$Time)
data$cDate <- as.POSIXct(strptime(data$cDate, format = "%d/%m/%Y %H:%M:%S", tz = "Europe/London"))

# set device to png
png(filename = "plot3.png", width = 480, height = 480)

# plot to png
plot(data$cDate, data$Global_active_power, xlab = "", ylab = "Energy sub metering", type = "n", ylim = c(0,  40))
with(data, lines(cDate, Sub_metering_1, col="black"))
with(data, lines(cDate, Sub_metering_2, col="red"))
with(data, lines(cDate, Sub_metering_3, col="blue"))
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col=c("black", "red", "blue"), lty = 1)

# close device
dev.off()