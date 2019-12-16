# using checkPackages, downloadAndExtract, loadData from plot1.R
# plot1.R has been updated
source("plot1.R")

createPlot4 <- function() {
    checkPackages(c("dplyr", "lubridate"))
    
    startDate <- ymd("2007-02-01")
    endDate <- startDate + days(1)
    
    data <- loadData(downloadAndExtract(), startDate, endDate)

    graphName <- "plot4.png"
    if (file.exists(graphName)) {        
        file.remove(graphName)
    }

    png(graphName, width = 480, height = 480)

    par(mfrow = c(2, 2))
    
    plot(data$DateTime,
         data$Global_active_power,
         type = "l",
         xlab = "",
         ylab = "Global Active Power")

    plot(data$DateTime,
         data$Voltage,
         type="l",
         xlab="datetime",
         ylab="Voltage")

    plot(data$DateTime,
         data$Sub_metering_1,
         type = "l",
         xlab = "",
         ylab = "Energy sub metering",
         ylim = c(0, 40),
         col = "black")
    
    lines(data$DateTime,
          data$Sub_metering_2,
          col = "red")

    lines(data$DateTime,
          data$Sub_metering_3,
          col = "blue")

    legend("topright",
           lty = 1,
           legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
           col = c("black", "red", "blue"))
    
    plot(data$DateTime,
         data$Global_reactive_power,
         type = "l",
         xlab = "datetime",
         ylab = "Global_reactive_power")

    dev.off()
}

createPlot4()

