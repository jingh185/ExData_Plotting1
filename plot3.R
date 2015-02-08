
##When loading the dataset into R, please consider the following:

##The dataset has 2,075,259 rows and 9 columns. First calculate a rough estimate of how much memory the dataset will require in memory before reading into R. Make sure your computer has enough memory (most modern computers should be fine).

##We will only be using data from the dates 2007-02-01 and 2007-02-02. One alternative is to read the data from just those dates rather than reading in the entire dataset and subsetting to those dates.

##You may find it useful to convert the Date and Time variables to Date/Time classes in R using the strptime() and as.Date() functions.

##Note that in this dataset missing values are coded as ?.


##loading data into data table
data <- read.table ("household_power_consumption.txt", sep =';', header = TRUE)

##adding a new column and covert into datetime
data$newdate <-  as.Date(data$Date, "%d/%m/%Y")

##only getting data between 2007-02-01 and 2007-02-02
subset <- data[which(data$newdate >= "2007-02-01" & data$newdate < "2007-02-03"),]

##adding a new column and convert into numeric Global_active_power
subset$new_Global_active_power <-  as.numeric(paste(subset$Global_active_power))

##combine date and time
subset$new_datetime <- strptime(paste(subset$Date, subset$Time), format = "%d/%m/%Y %H:%M:%S")

subset[,7] <- as.numeric(paste(subset[,7]))
subset[,8] <- as.numeric(paste(subset[,8]))


##Plot 3 data 
p3 <- subset[, c("new_datetime", "Sub_metering_1", "Sub_metering_2", "Sub_metering_3")]

#set to display only one row and one column
par(mfrow = c(1,1))

#set margin
par(mar = c(4,4.5,2,2))

## output plot into PNG
plot(x = p3$new_datetime, y= p3$Sub_metering_1, type = "l", xlab = "", ylab= "Energy sub metering")
lines (x = p3$new_datetime, p3$Sub_metering_2, type = "l", col="red")
lines (x = p3$new_datetime, p3$Sub_metering_3, type = "l", col="blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2","Sub_metering_3"), 
       lty = c(1, 1), lwd = c(1, 1, 1), cex=0.7, x.intersp = 0.6, y.intersp = 0.65,
       col=c("black","red","blue"))
dev.copy(png, file = "plot3.png", width = 480, height = 480)
dev.off()
