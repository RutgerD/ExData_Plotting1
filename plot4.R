# Create directory for download if necessary
if(!file.exists("assignment")) {
  dir.create("assignment")
}

# Check if zip-file has been downloaded. If not, download it
if(!file.exists("./assignment/hpc.zip")) {
  fileUrl<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
  download.file(fileUrl, destfile = "./assignment/hpc.zip")
}

# Check if zip-file has been unzipped. If not, unzip it
if(!file.exists("./assignment/household_power_consumption.txt")) {
  unzip("./assignment/hpc.zip", exdir = "./assignment")
}

# Read selection of correct time points (rows) from file.
hpc<-read.table("./assignment/household_power_consumption.txt", sep= ";", header =
                                      FALSE, skip=66637, nrows=2880)


# Check for NA values (here assigned with "?", and stop execution with error message
na_values<-!grep("?", hpc)
if (sum(na_values)!=0){stop("THERE ARE NA VALUES IN THE DATA")}

#Get column names from first row in data set and name columns in hpc accordingly

col_labels<-read.table("./assignment/household_power_consumption.txt", sep= ";", header =
                         FALSE, nrows=1, stringsAsFactors = FALSE)
names(hpc)<-col_labels

#Create new column with increasing measurement number
hpc$intervals<-time(hpc$Time)

# Open graphical device (don't know why, but otherwise it gives margin errors)
windows()

# Define that we want four plots, in order (top left, bottom left, top right, bottom right)
par(mfcol=c(2,2))

# PLOT 1
plot(hpc$intervals, hpc$Global_active_power, type="l", lwd=0.05, ylab="Global Active Power (kiloWatts)", xaxt="n", xlab="")
axis(1, at=c(0,1440,2880), labels= c("Thur", "Fri", "Sat"))

# PLOT 2
plot(hpc$intervals, hpc$Sub_metering_1, type="l", ylab="Energy sub metering", xaxt="n", xlab="", col="black")
lines(hpc$intervals, hpc$Sub_metering_2, col="red")
lines(hpc$intervals, hpc$Sub_metering_3, col="blue")
legend("topright", lty=1, col=c("black", "red", "blue"), legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
axis(1, at=c(0,1440,2880), labels= c("Thur", "Fri", "Sat"))

# PLOT 3
plot(hpc$intervals, hpc$Voltage, type="l", lwd=0.05, ylab="Voltage", xaxt="n", xlab="datetime")
axis(1, at=c(0,1440,2880), labels= c("Thur", "Fri", "Sat"))

# PLOT 4
plot(hpc$intervals, hpc$Global_reactive_power, type="l", ylab="Global Reactive Power", xaxt="n", xlab="datetime")
axis(1, at=c(0,1440,2880), labels= c("Thur", "Fri", "Sat"))


# Copy plot to png file, and save in assignment directory
dev.copy(png, file= "./assignment/plot4.png")
dev.off()