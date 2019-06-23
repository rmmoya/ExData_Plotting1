# Step 1 - Import data
# names(data) <- c('Date', 'Time', 'Global_active_power', 'Global_reactive_power', 'Voltage',
#                 'Global_intensity', 'Sub_metering_1', 'Sub_metering_2', 'Sub_metering_3')

require(readr)
require(dplyr)

data <- read_delim('C:\\temp\\household_power_consumption.txt', delim = ";", col_names = TRUE,
                 col_types = "ccddddddd", na = "?")
data <- data %>% 
  mutate(Date = parse_datetime(as.character(Date), '%d/%m/%Y'),
         Time = parse_time(as.character(Time), '%T'))

# Step 2 - Take only 2 dates: 2007-02-01 and 2007-02-02
data <- data %>% filter(Date == parse_datetime("2007-02-01", format = "%Y-%m-%d") |
                          Date == parse_datetime("2007-02-02", format = "%Y-%m-%d"))

# Step 3 - Plot
png(filename = "plot3.png",
    width = 480, height = 480, units = "px", pointsize = 12,
    bg = "white", res = NA, family = "", restoreConsole = TRUE,
    type = c("windows", "cairo", "cairo-png"))

with(data, plot(Date+Time, Sub_metering_1, type = "n",
                ylab = "Energy sub metering", xlab = ""))
with(data, lines(Date+Time, Sub_metering_1, col = "black"))
with(data, lines(Date+Time, Sub_metering_2, col = "red"))
with(data, lines(Date+Time, Sub_metering_3, col = "blue"))

legend("topright", 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       col = c("black", "red", "blue"), lty = 1, bty = "n")

dev.off()