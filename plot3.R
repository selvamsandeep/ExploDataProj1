#This scrit plot the line graph between datatime and 3 sub metering  
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

with(hpcData, plot(wDays, Sub_metering_1,type ="n", 
                   xlab="",ylab ="Energy sub metering" ))

#lines for Sub meterings
with(hpcData,lines(wDays,Sub_metering_1,col="black",lwd= 1))
with(hpcData,lines(wDays,Sub_metering_2,col="red",lwd= 1))
with(hpcData,lines(wDays,Sub_metering_3,col="blue",lwd= 1))

#legend creations
legend("topright", lty =c(1,1,1), col = c("black","blue", "red"), 
       legend = c("Sub_metering_1", "Sub_metering_2","Sub_metering_3"))


## copy the plot in to png and save it 
dev.copy(png,width =480, height = 480,"plot3.png")
dev.off()