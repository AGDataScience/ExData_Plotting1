library(readr)
library(tidyr)
library(dplyr)
library(lubridate)

## Download the data and unzip the file ---------
file_url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(file_url, "household_power_consumption.zip")

## Loading the data
df <- read_delim(file = "household_power_consumption.zip", delim = ";",
                 col_names = TRUE, guess_max = 2500000)

## Replace ? with NAs
df[df == "?"] <-  NA

## Convert columns into numeric
df <- mutate_at(df, 3:9, funs(as.numeric))

## Convert Date and Time columns as appropriate and create a DateTime column
df$Date <- as.Date(df$Date, "%d/%m/%Y")
df <- mutate(df, DateTime = paste(Date, Time))
df <- df[, c(1,2,10,3:9)]
df$DateTime <- ymd_hms(df$DateTime)


## Select the 2007-02-01 and 2007-02-02
df_s <- df[df$Date %in% as.Date(c("2007-02-01","2007-02-02")),]
df_s


## Plot 2
png(filename="plot2.png", width = 480, height = 480)
plot(df_s$DateTime, df_s$Global_active_power, type = "l", 
     xlab = "", ylab = "Global active power (kilowatts)")
dev.off()

