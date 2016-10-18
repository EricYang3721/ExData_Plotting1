sprintf("Memory needed to load the data set - household power consumption %f MB", 2075259*9*8/2^20)
# Loading the data
data <- read.table("./data/household_power_consumption.txt", sep = ";", header=TRUE) # read the data

data$Date <- as.Date(data$Date, '%d/%m/%Y') # convert date
data$Time <- format(as.POSIXlt(data$Time, format="%H:%M:%S"), format="%H:%M:%S")  #convert time
data <- data[data$Date == as.Date("2007-02-01") | data$Date == as.Date("2007-02-02"),]   # Select the data == 2007-02-01 and 2007-02-02

# Making plots
indx <- sapply(data, is.factor)   # check which column is factor
data[indx] <- lapply(data[indx], function(x) as.numeric(as.character(x)))   # Change factor columns into numeric
#make plot1.png
png(file="plot1.png", width = 480, height = 480)
hist(data$Global_active_power, col='red', xlab="Global Active Power(kilowatts)", ylab="Frequency", main="Global Active Power")
dev.off()