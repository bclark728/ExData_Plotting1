plot2 <- function() {  
  # read in data
  raw <- read.csv("./household_power_consumption.txt", sep=";")
  
  # extract from 2007-02-01 and 2007-02-02
  slicer <- as.Date(as.character(raw$Date), format="%d/%m/%Y") == as.Date("2007-02-01") | 
            as.Date(as.character(raw$Date), format="%d/%m/%Y") == as.Date("2007-02-02")
  slice  <- raw[slicer,]
  
  # throw out the garbage
  rm(raw)
  
  # open png device
  png(filename = "./plot2.png", height = 480, width = 480, bg = "transparent")
  
  # merge date into time to properly segment x axis
  times <- as.POSIXct(strptime(paste(as.character(slice$Date), as.character(slice$Time)), 
                       format <- "%d/%m/%Y %H:%M:%S"))
  
  # plot the data
  p <- plot(x = times, y = as.numeric(as.character(slice$Global_active_power)), 
            type="l", ylab = "Global Active Power (kilowatts)", xlab = "")
  
  # write to file
  print(p)
  dev.off()
  
  slice
}