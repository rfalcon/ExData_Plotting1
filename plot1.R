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

# convert date and time factor variables to their corresponding R classes
dataFrame$Date <- as.Date(dataFrame$Date, "%d/%m/%Y")
dataFrame$Time <- strptime(dataFrame$Time, "%H:%M:%S")

## 2. build plot #1 and save it to a PNG file 
## with width = height = 480 pixels
png(filename = "plot1.png")

hist(dataFrame$Global_active_power, 
     main = "Global Active Power", 
     col = "red",
     breaks = 12,
     xlab = "Global Active Power (kilowatts)"
)

dev.off()