sprintf("Memory needed to load the data set - household power consumption %f MB", 2075259*9*8/2^20)
# Loading the data
data <- read.table("./data/household_power_consumption.txt", sep = ";", header=TRUE) # read the data

data$Date <- as.Date(data$Date, '%d/%m/%Y') # convert date
data$Time <- format(as.POSIXlt(data$Time, format="%H:%M:%S"), format="%H:%M:%S")  #convert time
data <- data[data$Date == as.Date("2007-02-01") | data$Date == as.Date("2007-02-02"),]   # Select the data == 2007-02-01 and 2007-02-02

# Making plots
indx <- sapply(data, is.factor)   # check which column is factor
data[indx] <- lapply(data[indx], function(x) as.numeric(as.character(x)))   # Change factor columns into numeric
# Making plot3
date_time <- strptime(paste(data$Date, data$Time, sep=" "), "%Y-%m-%d %H:%M:%S")
png(file="plot3.png", width = 480, height = 480)
data$Date_Time <- as.POSIXct(date_time)
with(data, {
  plot(Sub_metering_1~Date_Time, type='l', xlab="", ylab="Energy sub metering")
  lines(Sub_metering_2~Date_Time, col='red')
  lines(Sub_metering_3~Date_Time, col='blue')
}
)
legend("topright", lty=1, col=c("black", "red", "blue"), legend=c('Sub_metering_1','Sub_metering_2', 'Sub_metering_3'))
dev.off()