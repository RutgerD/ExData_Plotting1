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

# Open graphical device (don't know why, but otherwise it gives margin errors)
windows()

# Create histogram

hist(hpc$Global_active_power, col="red", main="Global Active Power", xlab="Global Active Power (kiloWatts)")

# Copy plot to png file, and save in assignment directory
dev.copy(png, file= "./assignment/plot1.png")
dev.off()