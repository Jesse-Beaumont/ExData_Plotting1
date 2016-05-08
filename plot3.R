# -----------------------------------------------------------------------------
#  For each plot you should
#
#  - Construct the plot and save it to a PNG file with a
#    width of 480 pixels and a height of 480 pixels.
#
#  - Name each of the plot files as plot1.png, plot2.png, etc.
#
#  - Create a separate R code file (plot1.R, plot2.R, etc.) that constructs
#    the corresponding plot, i.e. code in plot1.R constructs the plot1.png plot.
#    Your code file should include code for reading the data so that the plot
#    can be fully reproduced. You must also include the code that creates
#    the PNG file.
#
#  - Add the PNG file and R code file to the top-level folder of your git
#    repository (no need for separate sub-folders)
#
# -----------------------------------------------------------------------------

# ----------------------------------------------
#  Read Household Power Consumption Data
# ----------------------------------------------
source("./read_the_data.R")
hpc <- readSourceData()

# ----------------------------------------------
#  Plot
# ----------------------------------------------

png(filename = "plot3.png",
    width = 480, height = 480)

par(bty="l",las = 1,lwd = 1,
    oma = c(1, 1, 0, 1),
    mar = c(3, 4, 3.5, 0))

plot(hpc$Datetime, hpc$Sub_metering_1,
     xlab = "",
     ylab = "Energy sub metering",
     type = "l", col="black")
par(new=TRUE)
lines(hpc$Datetime, hpc$Sub_metering_2, type = "l", col="red")
par(new=TRUE)
lines(hpc$Datetime, hpc$Sub_metering_3, type = "l", col="blue")
legend("topright",
      legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
      col = c("black", "red", "blue"),
      lwd=1)

dev.off()
