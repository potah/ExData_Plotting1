

checkPackages <- function(packageNames) {
    # make sure we remove duplicates
    packageNames <- unique(packageNames)
    installedPackages <- installed.packages()[,1]

    #sapply(packageNames, getInstallPackageFunction())
    sapply(packageNames,
           function(pkg) {
               if (!is.element(pkg, installedPackages)) {
                   install.packages(pkg)
               }
               # use character.only for a character vector
               require(pkg,
                       character.only = TRUE,
                       warn.conflicts = FALSE,
                       quietly = TRUE)
           })
}


downloadAndExtract <- function() {
    dataFileZip <- "household_power_consumption.zip"
    dataFile <- "household_power_consumption.txt"

    if (!file.exists(dataFile)) {        
        if (!file.exists(dataFileZip)) {
            url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"

            download.file(url = url, destfile = dataFileZip, method = "auto", quiet = TRUE)
        }
        
        # remove txt files in the current directory
        # ** don't do this - wasteful, we'll hard code the txt file output in this func
        # file.remove(dir()[grep("txt$", dir())])

        # unzip the file
        unzip(dataFileZip)        
    }

    # return the extracted txt file name
    #dir()[grep("txt$", dir())]
    dataFile
}

loadData <- function(dataFile, startDate, endDate) {
    data <- tbl_df(read.table(dataFile,
                              header = TRUE,
                              sep = ';',
                              na.strings = '?',
                              stringsAsFactors = FALSE))

    # check our data frame
    expectedNames = c("Date",
                      "Time",
                      "Global_active_power",
                      "Global_reactive_power",
                      "Voltage",
                      "Global_intensity",
                      "Sub_metering_1",
                      "Sub_metering_2",
                      "Sub_metering_3")

    # dim spits out integers
    expectedDimension = c(2075259L, 9L)

    stopifnot(identical(expectedNames, names(data)))
    stopifnot(identical(expectedDimension, dim(data)))

    # transform the date and time columns then filter on the date range
    data %>%
        mutate(Date = dmy(Date), Time = hms(Time), DateTime = Date + Time) %>%
        filter(Date >= startDate, Date <= endDate)
        
}

createPlot1 <- function() {
    checkPackages(c("dplyr", "lubridate"))
    
    startDate <- ymd("2007-02-01")
    endDate <- startDate + days(1)
    
    data <- loadData(downloadAndExtract(), startDate, endDate)

    graphName <- "plot1.png"
    if (file.exists(graphName)) {        
        file.remove(graphName)
    }
    
    png(graphName, width = 480, height = 480)

    hist(data$Global_active_power,
         main = "Global Active Power",
         xlab = "Global Active Power (kilowatts)",
         col = "red")
    
    dev.off()
}
    
createPlot1()

