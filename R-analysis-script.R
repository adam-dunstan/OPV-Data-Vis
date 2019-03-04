#Set working directory to where your test .txt files are for each finger
#WARNING: DO NOT HAVE REPLICATES OR RETESTS IN THE FOLDER. ONE .txt FILE FOR EACH FINGER, 6 FINGERS PER DEVICE
setwd("C:/Users/UON/Desktop/TESTdata")

#Creating variable "my.files" & "my.data" to collate all of the .txt files in the folder
  my.files <- list.files(pattern = ".txt")
  my.data <- lapply(my.files, read.csv, header=TRUE, sep="\t", skip = "21" )

#Creating a loop to plot Jsc/V Curves for each row of my.data (each .txt file), with parameters and pdf generation.
  par(mfrow =c(2,2))  
  for (i in 1:length(my.data))
    {
    plot(my.data[[i]]$U..V.,my.data[[i]]$J..mA.cm2., main = i, xlab = "Volatge (V)", ylab = "Jsc (mA/cm^2)", main = "")
    }
