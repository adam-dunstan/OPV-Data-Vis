#Created by Adam Dunstan 07/07/2019
#Prompt user for directory path & file select. Followed by object definitions.
library(ggplot2)
wd<-choose.dir()
setwd(wd)
my.files <- choose.files()
my.data <- lapply(my.files, read.csv, header=TRUE, sep="\t", skip = "21", colClasses=c(NA,"NULL"))
my.fingers <-  unlist(lapply(my.files, read.csv, header=FALSE, sep="\t", skip = "6", colClasses=c("NULL", NA), nrows = 1) )
my.devices <-  unlist(sapply(my.files, read.csv, header=FALSE, sep="\t", simplify = TRUE, skip = "2", colClasses=c("NULL", NA), nrows = 1), recursive = TRUE)
comment <- unlist(sapply(my.files, read.csv, header=FALSE, sep="\t", simplify = TRUE, skip = "10", colClasses=c("NULL", NA), nrows = 1), recursive = TRUE)
testname <- unlist(sapply(my.files, read.csv, header=FALSE, sep="\t", simplify = TRUE, skip = "3", colClasses=c("NULL", NA), nrows = 1), recursive = TRUE)
PCEvec <- unlist(lapply(my.files, read.csv, header=FALSE, sep="\t", skip = "13", colClasses=c("NULL", NA), nrows = 1) )
#The first image will be a check, testing the script.
v <- c("Script diagnostics page",paste("Number of files: ",length(my.data)),paste("Test: ",levels(testname)))
jpeg("diagnostics.jpg")
par(mfrow =c(1,1))
plot.new()
title(main = v, sub= "If there are any issues with the script, send me an email via adam.dunstan@uon.edu.au" )
dev.off()
#The following images within the for loop are the J/V Curves!
for (i in 1:length(my.files)){
  imgnm <- paste("OPV-Plot",i,".jpg")
  jpeg(imgnm)
  
  x <- paste("Finger", my.fingers[i],"Device",my.devices[i], sep =" " )
  
  plot(my.data[[i]]$U..V.,my.data[[i]]$J..mA.cm2., main = x, sub = paste("Fig.",i,":",comment), xlab = "Volatge (V)", ylab = "Jsc (mA/cm^2)", xlim = c(-0.5,1), ylim = c(-15,0)
)
  axis(1, pos=0, labels = FALSE, tick = TRUE, col = "black")
  axis(2, pos=0, labels = FALSE, tick = TRUE, col = "black")
 dev.off()
}
#Next we will print a histogram of the PCEs of each finger as a generalization, then another catergorized by device. This may indicate issues with manufacturing methods & techniques.
jpeg("Test-General-Boxplot.jpg")
boxplot(PCEvec, main = "Summary of Test Efficiency", ylab = "Power Conversion Efficiency (%)")
dev.off()

#Compare all devices using PCE. (To highlight differences between manufacturing different devices as they are produced one device at a time.)
m1<-cbind(my.devices,PCEvec)
m2<-split.data.frame(m1,my.devices, drop=FALSE)

#Compare all fingers using PCE. (To highlight differences on specific areas of the devices. May suggest particular areas that are often damaged or undeveloped.)

#Tell user that the script is finished!
library(beepr)
beep(sound = 2)
Sys.sleep(3)
dev.off()
q()
y
