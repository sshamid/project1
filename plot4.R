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

##plot4
scale<-0.85
png("plot4.PNG", width = 480, height = 480)
par(mfrow=c(2,2))
plot(as.numeric(DT$Global_active_power), type="l", ylab="Global Active Power", xlab="", xaxt="n", cex.lab=scale, cex.axis=scale)
axis(side=1, at=c(0, 1440, 2880),  labels=c("Thu", "Fri", "Sat"), cex.lab=scale, cex.axis=scale)

plot(as.numeric(DT$Voltage), type="l", ylab="Voltage", xlab="datetime", xaxt="n", cex.lab=scale, cex.axis=scale)
axis(side=1, at=c(0, 1440, 2880),  labels=c("Thu", "Fri", "Sat"), cex.lab=scale, cex.axis=scale)

plot(as.numeric(DT$Sub_metering_1), type="l", ylab="Energy sub metering", xlab="", xaxt="n", col="black", cex.lab=scale, cex.axis=scale)
lines(as.numeric(DT$Sub_metering_2), type="l", col="red")
lines(as.numeric(DT$Sub_metering_3), type="l", col="blue")
axis(side=1, at=c(0, 1440, 2880),  labels=c("Thu", "Fri", "Sat"), cex.lab=scale, cex.axis=scale)

legend(
  "topright",
  legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
  lty=c(1, 1, 1),
  lwd=c(2.5, 2.5, 2.5),
  bty="n",
  col=c("black", "red", "blue"),
  inset=0.02,
  cex=scale)

plot(as.numeric(DT$Global_reactive_power), type="l", ylab="Global_reactive_power", xlab="datetime", xaxt="n", cex.lab=scale, cex.axis=scale)
axis(side=1, at=c(0, 1440, 2880),  labels=c("Thu", "Fri", "Sat"), cex.lab=scale, cex.axis=scale)
dev.off()
