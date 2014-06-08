wd <- getwd()
datafile <- "household_power_consumption"
txtfile <- paste(paste(wd, datafile, sep = "/"), ".txt", sep="")

if (!file.exists(txtfile)){
  dataUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
  downloadedzipfile <- paste(paste(wd, datafile, sep = "/"), ".zip", sep="")
  download.file(dataUrl, destfile = downloadedzipfile, method = "curl")
  dateDownloaded <- data()
  unzip(downloadedzipfile)
}

library(data.table)
DT <- fread(txtfile, na.strings="?")
DT <- DT[(DT$Date == "1/2/2007") | (DT$Date == "2/2/2007"), ]
DT$datetime <- as.POSIXct(DT$Date, format="%d/%m/%Y") + as.ITime(DT$Time, format="%H:%M:%S")

##plot2
plot(as.numeric(DT$Global_active_power), type="l", ylab="Global Active Power (kilowatts)", xlab="", xaxt="n")
axis(side=1, at=c(0, 1440, 2880),  labels=c("Thu", "Fri", "Sat"))
dev.print(png, file = "plot2.PNG", width = 480, height = 480)
dev.off()
