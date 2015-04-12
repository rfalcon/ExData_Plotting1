
## 0. make sure required libraries are available

if (!( "lubridate" %in% rownames(installed.packages())))
  install.packages("lubridate")

library(lubridate)

## 1. read relevant information from the input data file

# 1.1 check if the input file exists in the working directory
# and if not, download it

inputFileNameRoot <- "household_power_consumption"

if (!file.exists(paste0(inputFileNameRoot, ".txt"))) {
  download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", paste0(inputFileNameRoot, ".zip"))
  unzip(paste0(inputFileNameRoot, ".zip"))
  file.remove(paste0(inputFileNameRoot, ".zip"))
}

# 1.2 read desired subset of data from the input file

# get the header names
# we will be using 'skip' later on and it will skip this line too
columnNames <-  scan(paste0(inputFileNameRoot, ".txt"),sep=';', 
                     what="character" , nlines=1 )

# read the two-day subset of data from the input file
# the values for the 'skip' and 'nrows' input arguments have been determined 
# by using exploratory functions like head(), tail(), str(), etc.

dataFrame <- read.table(paste0(inputFileNameRoot, ".txt"), 
                        header=T, 
                        sep=";", 
                        na.strings = "?",
                        stringsAsFactors = F,
                        skip = 66636, 
                        nrows = 2880, 
                        col.names = columnNames)


## 2. build plot #2 and save it to a PNG file 
## with width = height = 480 pixels
png(filename = "plot2.png")

# create a DateTime variable for the x axis in the plot
dateTimeVar <- dmy_hms(paste(dataFrame$Date, dataFrame$Time))

# set margins
par(mar=c(4.1, 6.1, 4.1, 2.1))

# create plot but do not display data yet
plot(dateTimeVar, dataFrame$Global_active_power, 
     type="n",
     xlab = "", 
     ylab = "Global Active Power (kilowatts)",
    )

# plot lines
lines(dateTimeVar, dataFrame$Global_active_power)

# close device
dev.off()