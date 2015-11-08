# plot1.R
# Load libraries
require(data.table);
require(lubridate);

hpc <- fread("household_power_consumption.txt", header=TRUE,
             nrows=5000000, skip=0, verbose=TRUE, na.strings = "?");
column.names = colnames(thisTable);

# Fix Dates
hpc[, Date := as.Date(Date, format = "%d/%m/%Y")];
hpc[, Time := as.ITime(Time)];
hpc2 <- hpc[hpc$Date=='2007-02-01' | hpc$Date=='2007-02-02', ];

# Make Plot
png("plot1.png", width = 480, height = 480, units = "px");
par(mar=c(4,4,1,1));
hist(hpc2$Global_active_power, col = "red", main = "Global Active Power",
     xlab = "Global Active Power (kilowatts)");
dev.off();
