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
plot(hpc$Datetime, hpc$Global_active_power,
     xlab = "",
     ylab = "Global Active Power (kilowatts)",
     type = "l")

dev.copy(png, filename = "plot2.png",
         width = 480, height = 480, units = "px", bg = "white")
dev.off()
