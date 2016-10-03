rm(list = ls())
graphics.off()

data = read.csv("error.csv", header = FALSE);
baseline = data[data[1] == 'baseline',]
omp2 = data[data[1] == 'omp2',]
omp4 = data[data[1] == 'omp4',]
avx = data[data[1] == 'avx',]
avx_unroll =  data[data[1] == 'avxunroll',]

# plot orignal data
png(filename = "error.png" , width = 1920 , height = 1920*0.75)
#X11()
plot(baseline[,2], baseline[,3], type = 'l' , col = "red",
     xlab = "N", ylab = "error" , main = "error")
lines(omp2[,2], omp2[,3], type = 'l' , col = "blue")
lines(omp4[,2], omp4[,3], type = 'l' , col = "black")
lines(avx[,2], avx[,3], type = 'l' , col = "yellow")
lines(avx_unroll[,2], avx_unroll[,3], type = 'l' , col = "green")

legend('topleft', # places a legend at the appropriate place 
       c("baseline", "omp2", "omp4","avx","avx_unroll"), # puts text in the legend
       lty=c(1,1,1,1,1), # gives the legend appropriate symbols (lines)
       lwd=c(2.5,2.5,2.5,2.5,2.5),col=c("red","blue", "black","yellow","green"))
dev.off()