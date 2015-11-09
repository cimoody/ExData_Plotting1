# plot4.R
# Load libraries
require(data.table);

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
png("plot4.png", width = 480, height = 480, units = "px");
par(mfrow=c(2,2));
plot(x = hpc2$DateTime, y = hpc2$Global_active_power, xlab = "",
     ylab = "Global Active Power", type = "l");
plot(x = hpc2$DateTime, y = hpc2$Voltage, xlab = "datetime",
     ylab = "Voltage", type = "l");
plot(x = hpc2$DateTime, y = hpc2$Sub_metering_1, xlab = "",
     ylab = "Energy sub metering", type = "l", col = "black");
lines(x = hpc2$DateTime, y = hpc2$Sub_metering_2, type = "l", col = "red");
lines(x = hpc2$DateTime, y = hpc2$Sub_metering_3, type = "l", col = "blue");
legend('topright', c("Sub_metering_1","Sub_metering_2", "Sub_metering_3"),
       bty = "n", lty = c(1,1,1), lwd = c(2.5,2.5),
       col = c("black", "red", "blue"));
plot(x = hpc2$DateTime, y = hpc2$Global_reactive_power, xlab = "datetime",
     ylab = "Global_reactive_power", type = "l");
dev.off();
