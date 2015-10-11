
# using checkPackages, downloadAndExtract, loadData from plot1.R
source("plot1.R")

createPlot2 <- function() {
    checkPackages(c("dplyr", "lubridate"))
    
    startDate <- ymd("2007-02-01")
    endDate <- startDate + days(1)
    
    data <- loadData(downloadAndExtract(), startDate, endDate)

    graphName <- "plot2.png"
    if (file.exists(graphName)) {        
        file.remove(graphName)
    }
    
    png(graphName, width = 480, height = 480)

    plot(data$DateTime,
         data$Global_active_power,
         type = "l",
         xlab = "",
         ylab = "Global Active Power (kilowatts)")
    
    dev.off()
}

createPlot2()

