library(dplyr)

dataset <- read.csv2("YOURFILEPATH\\household_power_consumption.txt", header=T, sep=";")
dataset$Days <- weekdays(strptime(gsub(" ","",paste(dataset$Date,":",dataset$Time)),format='%d/%m/%Y:%H:%M:%S'))
dataset$DaysNTimes<-paste0(dataset$Date,":",dataset$Time)
dataset$DaysNTimes<-strptime(dataset$DaysNTimes,format='%d/%m/%Y:%H:%M:%S')
dataset$Date<-strptime(dataset$Date, format= "%d/%m/%Y")
dataset$Date<-as.POSIXct(dataset$Date)
dataset$DaysNTimes<-as.POSIXct(dataset$DaysNTimes)
wf <-filter(dataset, dataset$Date == "2007-02-01" | dataset$Date == "2007-02-02")
wf$Global_active_power<-as.numeric(as.character(wf$Global_active_power))
wf$Global_reactive_power<-as.numeric(as.character(wf$Global_reactive_power))
wf$Voltage<-as.numeric(as.character(wf$Voltage))
wf$Global_intensity<-as.numeric(as.character(wf$Global_intensity))
wf$Sub_metering_1<-as.numeric(as.character(wf$Sub_metering_1))
wf$Sub_metering_2<-as.numeric(as.character(wf$Sub_metering_2))
wf$Sub_metering_3<-as.numeric(as.character(wf$Sub_metering_3))


wf1<-select(wf,Date,Days,DaysNTimes,Global_active_power,Global_reactive_power,Voltage,Global_intensity,Sub_metering_1,Sub_metering_2,Sub_metering_3)

par(mfrow = c(2,2))
####plot4

plot(wf1$DaysNTimes,wf$Global_active_power, type="l", ylab="Global Active Power", xlab="")
plot(wf1$DaysNTimes,wf1$Voltage, type="l", ylab="Voltage", xlab="datetime")
plot(wf1$DaysNTimes,wf1$Sub_metering_1, col="black", type="l", ylab="Energy sub metering",xlab="")
lines(wf1$DaysNTimes,wf1$Sub_metering_2,col="red",type="l")
lines(wf1$DaysNTimes,wf1$Sub_metering_3,col="blue",type="l")
plot(wf1$DaysNTimes,wf1$Global_reactive_power, type="l", ylab="Global_reactive_power", xlab="datetime")
dev.copy(png,"YOURFILEPATH\\plot4.png")
dev.off()