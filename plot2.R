# plot2.R
# Load libraries
require(data.table);
require(lubridate);

hpc <- fread("household_power_consumption.txt", header=TRUE,
             nrows=5000000, skip=0, verbose=TRUE, na.strings = "?");
column.names = colnames(hpc);

# Fix Dates
hpc[, Date := as.Date(Date, format = "%d/%m/%Y")];
hpc[, Time := as.ITime(Time)];
hpc2 <- hpc[hpc$Date=='2007-02-01' | hpc$Date=='2007-02-02', ];
DateTime <- strptime(paste(hpc2$Date, hpc2$Time), "%Y-%m-%d %H:%M:%S");
hpc2 <- cbind(hpc2, DateTime);
# Make Plot
png("plot2.png", width = 480, height = 480, units = "px");
par(mar=c(4,4,1,1));
plot(x = hpc2$DateTime, y = hpc2$Global_active_power, xlab = "",
     ylab = "Global Active Power", type = "l")
dev.off();
