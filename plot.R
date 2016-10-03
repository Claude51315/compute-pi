rm(list = ls())
graphics.off()

data = read.csv("output.csv", header = FALSE);
baseline = data[data[1] == 'baseline',]
omp2 = data[data[1] == 'omp2',]
omp4 = data[data[1] == 'omp4',]

png(filename = "plot.png")
plot(log10(baseline[,2]), baseline[,3], type = 'o' , col = "red",
     xlab = "N in log10", ylab = "execution time(sec)" , main = "performance comparison", 
     xlim = c(6 , 10))
lines(log10(omp2[,2]), omp2[,3], type = 'o' , col = "blue")
lines(log10(omp4[,2]), omp4[,3], type = 'o' , col = "black")
legend('topleft', # places a legend at the appropriate place 
      c("baseline", "omp2", "omp4"), # puts text in the legend
      lty=c(1,1,1), # gives the legend appropriate symbols (lines)
      lwd=c(2.5,2.5,2.5),col=c("red","blue", "black"))

dev.off()