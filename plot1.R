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


################################################################
# printing the plot to a png file
################################################################
png(filename = "plot1.png")
with(fpower, hist(Global_active_power, col='red', xlab = "Global Active Power (kilowatts)", ylab = "Frequency", ylim=c(0,1200), main = "Global Active Power", yaxp = c(0, 1200, 6)))
dev.off()
