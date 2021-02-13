## ----setup, include=FALSE-------------------------------------------------------------------------------------
knitr::opts_chunk$set(echo = TRUE)
library(R.utils)
library(dplyr)
library(lubridate)
library(knitr)
library(chron)


## ----getdataset-----------------------------------------------------------------------------------------------
#set working directory

setwd("C:/Users/rp303/OneDrive/Documents/coursera data science/ExData_Plotting1")

#create file

filename <- "exdata_data_household_power_consumption.zip"

## Check if the file exists already in the directory and if not, download and unzip the files in a folder
##named ExData_Plotting1

if (!file.exists(filename)){
  fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip "
  download.file(fileURL, filename, method="curl")
}  
if (!file.exists("exdata_data_household_power_consumption")) { 
  unzip(filename) 
}



## ----calcmemoryrequired---------------------------------------------------------------------------------------
# total lines on a file 
sourcefile <- "household_power_consumption.txt"
numrows <- countLines(sourcefile);
#read header row to determine number of columns
dat <- read.table(sourcefile, nrows = 1, header =TRUE, sep =';')[-1, ]
numcolumns=ncol(dat)

#calculate the memory required to read file before loading it
#memory required = no. of column * no. of rows * 8 bytes/numeric
#1 MB=1000 bytes

#bytes
memoryrequired=numcolumns*numrows*8 

#megabytes converted to bytes
memoryavailable=memory.size()  *1000

if (memoryrequired<=memoryavailable) {
  fileTooLarge= TRUE 
  } else {
    fileTooLarge=FALSE
  }



## -------------------------------------------------------------------------------------------------------------
if (!fileTooLarge) {
  df1<-read.table(sourcefile,header=TRUE, sep=";", stringsAsFactors=FALSE, dec=".")
  
  df2<-df1[df1$Date %in% c("1/2/2007","2/2/2007") ,]
}  
  


## -------------------------------------------------------------------------------------------------------------
#convert Global_active_power from chr to num
df2$Global_active_power=as.numeric(df2$Global_active_power)

#combine Date and Time into one field
datetime <- strptime(paste(df2$Date, df2$Time, sep=" "), "%d/%m/%Y %H:%M:%S") 

getwd()

#dev.cur()

#define destination for png
png("Plot2.png",width=480, height=480)

#Create plot of dates versus Global Active Power
plot(datetime,df2$Global_active_power, type="l", xlab="", ylab="Global Active Power (kilowatts)")

 
dev.off()


## -------------------------------------------------------------------------------------------------------------
#convert Rstudio rmd file to r file
knitr::purl("plot2.Rmd")


