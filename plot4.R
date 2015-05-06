library(lubridate)
library(dplyr)

################################################################
# preparing the data frame 'fpower' to be used to build figures
################################################################

# read in the data into dataframe named 'power'
power = read.table("household_power_consumption.txt", sep=";", header=T, na.strings = "?")

# filtering the 'power' data frame for dates between 2007-02-01 and 2007-02-02
fpower = power %>% 
  mutate(Date = dmy(Date), Global_active_power = as.numeric(Global_active_power)) %>% 
  filter(between(Date, ymd('2007-02-01'), ymd('2007-02-02')))

# merging the date and time variables into a new variable called datetime
fpower = mutate(fpower, datetime = ymd_hms(paste(Date, Time)))


################################################################
# printing the plot to a png file
################################################################

#prepare graphic device to load figures by row with mfrow
png(filename = "plot4.png")
par(mfrow = c(2,2))

#plot Global_active_power vs datetime
with(fpower, plot(Global_active_power ~ datetime, type="l", xlab = '', ylab = "Global Active Power"))

#plot Voltage vs datetime
with(fpower, plot(Voltage ~ datetime, type="l", xlab = 'datetime', ylab = "Voltage"))

#plot Energy sub metering vs datetime
with(fpower, {
  plot(Sub_metering_1 ~ datetime, col = 'black', type = "l", xlab = '', ylab = "Energy sub metering")
  lines(Sub_metering_2 ~ datetime, col = 'red', type = "l")
  lines(Sub_metering_3 ~ datetime, col = 'blue', type = "l")
})
legend('topright', bty = "n", legend = c('Sub_metering_1', 'Sub_metering_2', 'Sub_metering_3'), lty = c(1,1,1), col = c("black","red","blue" ))

#plot Global_reactive_power vs datetime
with(fpower, plot(Global_reactive_power ~ datetime, type="l"))

dev.off()
