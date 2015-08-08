
plot1 <- function() {  
  # read in data
  raw <- read.csv("./household_power_consumption.txt", sep=";")

  # extract from 2007-02-01 and 2007-02-02
  raw$Date <- as.Date(as.character(raw$Date), format="%d/%m/%Y")
  slicer   <- raw$Date == as.Date("2007-02-01") | raw$Date == as.Date("2007-02-02")
  slice    <- raw[slicer,]

  # throw out the garbage
  rm(raw)
  
  # open png device
  png(filename = "./plot1.png", height = 480, width = 480, bg = "transparent")

  # plot the data
  color = "#ff2500"
  p <- hist(as.numeric(as.character(slice$Global_active_power)), 
            main = "Global Active Power", xlab = "Global Active Power (kilowatts)", 
            col = color)

  # write to file
  print(p)
  dev.off()
}