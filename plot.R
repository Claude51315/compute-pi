rm(list = ls())
graphics.off()

data = read.csv("output.csv", header = FALSE);
baseline = data[data[1] == 'baseline',]
omp2 = data[data[1] == 'omp2',]
omp4 = data[data[1] == 'omp4',]
avx = data[data[1] == 'avx',]


png(filename = "plot.png")
plot(baseline[,2], baseline[,3], type = 'l' , col = "red",
     xlab = "N in log10", ylab = "execution time(sec)" , main = "performance comparison")
lines(omp2[,2], omp2[,3], type = 'l' , col = "blue")
lines(omp4[,2], omp4[,3], type = 'l' , col = "black")
lines(avx[,2], avx[,3], type = 'l' , col = "yellow")

legend('topleft', # places a legend at the appropriate place 
      c("baseline", "omp2", "omp4","avx"), # puts text in the legend
      lty=c(1,1,1,1), # gives the legend appropriate symbols (lines)
      lwd=c(2.5,2.5,2.5,2.5),col=c("red","blue", "black","yellow"))
dev.off()