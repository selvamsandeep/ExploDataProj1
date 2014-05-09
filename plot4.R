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

# 2rows and 2 colums
par(mfrow = c(2, 2))

#plot1
plot(wDays, hpcData$Global_active_power, type="l", xlab="",
     ylab="Global Active Power")

#plot 2
with(hpcData, plot(wDays,Voltage,type ="l", xlab="datetime",ylab ="Voltage"))

#plot3
with(hpcData, plot(wDays, Sub_metering_1,type ="n", 
                   xlab="",ylab ="Energy sub metering" ))

#lines for Sub meterings
with(hpcData,lines(wDays,Sub_metering_1,col="black",lwd= 1))
with(hpcData,lines(wDays,Sub_metering_2,col="red",lwd= 1))
with(hpcData,lines(wDays,Sub_metering_3,col="blue",lwd= 1))

#legend creations
legend("topright",bty = "n",cex =0.7, y.intersp =0.3,lty =1, 
       col = c("black","blue", "red"),
       legend = c("Sub_metering_1", "Sub_metering_2","Sub_metering_3"))  

#plot4
with(hpcData, plot(wDays,Global_reactive_power,type ="l", xlab="datetime",
                   ylab ="Global_reactive_power"))


## copy the plot in to png and save it 
dev.copy(png,width =480, height = 480,"plot4.png")
dev.off()