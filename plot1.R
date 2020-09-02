library("data.table")

# read data from text file
data <- fread("household_power_consumption.txt", na.strings="?")

# filter data and modify date data
data <- data[data$Date=="1/2/2007" | data$Date=="2/2/2007", ]
data$Date <- as.Date(data$Date, format = "%d/%m/%Y", tz = "CET")
#data <- data[data$Date=="2007-02-01" | data$Date=="2007-02-02", ]

# plot to screen
hist(data$Global_active_power, col = "red", xlab = "Global Active Power (kilowatts)", main = "Global Active Power")
par(xaxp  = c(0, 1200, 6))

# copy to png-file
dev.copy(png, file = "plot1.png", width = 480, height = 480)
dev.off()
