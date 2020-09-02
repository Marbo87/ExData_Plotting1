library("data.table")
Sys.setenv("LANGUAGE"="En")
Sys.setlocale("LC_ALL", "English")

# read data from text file
data <- fread("household_power_consumption.txt", na.strings="?")

# filter data and modify date variables
data <- data[data$Date=="1/2/2007" | data$Date=="2/2/2007", ]
data$cDate <- paste(data$Date, data$Time)
data$cDate <- as.POSIXct(strptime(data$cDate, format = "%d/%m/%Y %H:%M:%S", tz = "Europe/London"))

# plot to screen
plot(data$cDate, data$Global_active_power, xlab = "", ylab = "Global Active Power (kilowatts)", type = "n")
lines(data$cDate, data$Global_active_power)

# copy to png-file
dev.copy(png, file = "plot2.png", width = 480, height = 480)
dev.off()