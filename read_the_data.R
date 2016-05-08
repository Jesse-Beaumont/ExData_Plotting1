# -----------------------------------------------------------------------------
#   Exploring and Cleaning Data Programming Assignment #1
# -----------------------------------------------------------------------------
#
#  The source data contains the columns:
#
#  1. Date: Date in format dd/mm/yyyy
#  2. Time: time in format hh:mm:ss
#  3. Global_active_power: household global minute-averaged active power (in kilowatt)
#  4. Global_reactive_power: household global minute-averaged reactive power (in kilowatt)
#  5. Voltage: minute-averaged voltage (in volt)
#  6. Global_intensity: household global minute-averaged current intensity (in ampere)
#  7. Sub_metering_1: energy sub-metering No. 1 (in watt-hour of active energy).
#  8. Sub_metering_2: energy sub-metering No. 2 (in watt-hour of active energy).
#  9. Sub_metering_3: energy sub-metering No. 3 (in watt-hour of active energy).
#
# -----------------------------------------------------------------------------
#
#  The following are notes from the Assignment documentation:
#  (https://www.coursera.org/learn/exploratory-data-analysis/peer/ylVFo/course-project-1)
#
#  - When loading the dataset into R, please consider the following:
#
#  - The dataset has 2,075,259 rows and 9 columns. First calculate a rough estimate of
#    how much memory the dataset will require in memory before reading into R. Make
#    sure your computer has enough memory (most modern computers should be fine).
#
#  - We will only be using data from the dates 2007-02-01 and 2007-02-02.
#    One alternative is to read the data from just those dates rather than reading
#    in the entire dataset and subsetting to those dates.
#
#  - You may find it useful to convert the Date and Time variables to Date/Time
#    classes in R using the strptime()  and as.Date() functions.
#
#  - Note that in this dataset missing values are coded as ?.
#
# -----------------------------------------------------------------------------
library(lubridate)

# ----------------------------------------------
#   Sample the Source Data without reading
#   the entire source in at once.  Per the
#   requirements, only Feb 1st and 2nd observations
#   are to used.  Once the layout of the file
#   is understood, calibrate the "cutoff" to save
#   time.
#
#   (household_power_consumption.txt)
# ----------------------------------------------
readSourceData <- function() {

    interesting_dates = c("1/2/2007", "2/2/2007")

    # read the source file incrementally in 100,000 line chunks
    row_cursor <- 0
    chunk_size <- 100000

    # 1st pass of reading data. Initialize columns.
    repeat {
        hpc <- read.csv(file="./household_power_consumption.txt",
                  sep = ";",
                  header = TRUE,
                  colClasses = c("character", "character", "real", "real", "real", "real", "real", "real", "real"),
                  na.strings = c("?"),
                  skip=row_cursor,
                  nrow=chunk_size)

        # maintain column names
        colnames(hpc) = c("Date", "Time",
                          "Global_active_power", "Global_reactive_power",
                          "Voltage", "Global_intensity",
                          "Sub_metering_1", "Sub_metering_2", "Sub_metering_3")

        # check for EOF
        row_count <- nrow(hpc)
        if (row_count == 0) {
            print("No rows were read, break!")
            break
        #} else {
        #    print(paste(nrow(hpc), " rows read starting from ", row_cursor))
        }

        # keep only interesting rows
        hpc <- subset(hpc, hpc$Date %in% interesting_dates)
        #print(paste("Keeping ", nrow(hpc), " rows"))

        # initial read interation
        if (row_cursor == 0) {
            accumulated_hpc <- hpc
        } else {
            accumulated_hpc <- rbind(accumulated_hpc, hpc)
        }

        # increment the read cursor
        row_cursor <- (row_cursor + row_count)

        # cutoff (when it is known after data sampling)
        if (row_cursor == 100000) { # actual potential max = 2075259
            break
        }
    }
    dim(accumulated_hpc)
    # ----------------------------------------------
    #  Coerce Date/Times
    # ----------------------------------------------
    accumulated_hpc$Date <- as.Date(hpc$Date, format = "%d/%m/%Y")
    accumulated_hpc$Time <- hms(hpc$Time)
    accumulated_hpc$Datetime <- strptime(paste(hpc$Date, hpc$Time), format = "%d/%m/%Y %H:%M:%S")
    # ----------------------------------------------
    #  Return Value
    # ----------------------------------------------
    accumulated_hpc
}
# ----------------------------------------------
