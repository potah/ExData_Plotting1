# using checkPackages, downloadAndExtract, loadData from plot1.R
source("plot1.R")

createPlot3 <- function() {
    checkPackages(c("dplyr", "lubridate"))
    
    startDate <- ymd("2007-02-01")
    endDate <- startDate + days(1)
    
    data <- loadData(downloadAndExtract(), startDate, endDate)

    graphName <- "plot3.png"
    if (file.exists(graphName)) {        
        file.remove(graphName)
    }

    png(graphName, width = 480, height = 480)

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
    
    dev.off()
}

createPlot3()
