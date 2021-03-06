plot3 <- function() {  
  # read in data
  raw <- read.csv("./household_power_consumption.txt", sep=";")
  
  # extract from 2007-02-01 and 2007-02-02
  slicer <- as.Date(as.character(raw$Date), format="%d/%m/%Y") == as.Date("2007-02-01") | 
    as.Date(as.character(raw$Date), format="%d/%m/%Y") == as.Date("2007-02-02")
  slice  <- raw[slicer,]
  
  # throw out the garbage
  rm(raw)
  
  # open png device
  png(filename = "./plot3.png", height = 480, width = 480, bg = "transparent")
  
  # merge date into time to properly segment x axis
  times <- as.POSIXct(strptime(paste(as.character(slice$Date), as.character(slice$Time)), 
                               format = "%d/%m/%Y %H:%M:%S"))
  
  # fix typing
  slice$Sub_metering_1 <- as.numeric(as.character(slice$Sub_metering_1))
  slice$Sub_metering_2 <- as.numeric(as.character(slice$Sub_metering_2))
  
  # plot the data
  p <- plot(x = times, y = slice$Sub_metering_1, type="l", ylab = "Energy sub metering", 
            xlab = "", col = "black")
  lines(x = times, y = slice$Sub_metering_2, col = "red")
  lines(x = times, y = slice$Sub_metering_3, col = "blue")
  legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
         lty = c(1,1,1), lwd = c(1,1,1), col = c("black", "red", "blue"))
  
  # write to file
  print(p)
  dev.off()
  
  slice
}