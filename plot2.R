#This scrit plot the histogram for variable global_active_power 
#and save the plot in 'png file named  plot.png
#using sql qrery from sqldf packages read the required rows


if(!suppressWarnings(require ("sqldf"))){
    install.packages("sqldf")
    library("sqldf")
}


## reading only  data from the dates 2007-02-01 and 2007-02-02
fileName <- "household_power_consumption.txt"
mySql <- "SELECT * from file WHERE Date = '1/2/2007' OR Date = '2/2/2007'"
hpcData <- read.csv.sql(fileName, sql=mySql, sep=";")

##strptime turns character representations into an object of class POSIXlt
wDays <- strptime(paste(hpcData$Date,hpcData$Time), format='%d/%m/%Y %H:%M:%S')


plot(wDays, hpcData$Global_active_power, type="l", xlab="", ylab="Global Active Power (kilowatts)")


## copy the plot in to png and save it 
dev.copy(png,width =480, height = 480,"plot2.png")
dev.off()