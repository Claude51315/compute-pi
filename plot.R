rm(list = ls())
graphics.off()

data = read.csv("output.csv", header = FALSE);
baseline = data[data[1] == 'baseline',]
omp2 = data[data[1] == 'omp2',]
omp4 = data[data[1] == 'omp4',]
avx = data[data[1] == 'avx',]
avx_unroll =  data[data[1] == 'avxunroll',]


baseline_lr = lm (baseline[,3] ~ baseline[,2])
omp2_lr = lm (omp2[,3] ~ omp2[,2])
omp4_lr = lm (omp4[,3] ~ omp4[,2])
avx_lr = lm (avx[,3] ~ avx[,2])
avx_unroll_lr = lm (avx_unroll[,3] ~ avx_unroll[,2])

# plot orignal data
png(filename = "orignal.png" , width = 1280 , height = 1280*0.75)
plot(baseline[,2], baseline[,3], type = 'l' , col = "red",
     xlab = "N", ylab = "execution time(sec)" , main = "performance comparison (original)")
lines(omp2[,2], omp2[,3], type = 'l' , col = "blue")
lines(omp4[,2], omp4[,3], type = 'l' , col = "black")
lines(avx[,2], avx[,3], type = 'l' , col = "yellow")
lines(avx_unroll[,2], avx_unroll[,3], type = 'l' , col = "green")

legend('topleft', # places a legend at the appropriate place 
      c("baseline", "omp2", "omp4","avx","avx_unroll"), # puts text in the legend
      lty=c(1,1,1,1,1), # gives the legend appropriate symbols (lines)
      lwd=c(2.5,2.5,2.5,2.5,2.5),col=c("red","blue", "black","yellow","green"))
dev.off()
# plot regression line 
png(filename = "regression.png" , width = 1280 , height = 1280*0.75)
plot(baseline[,2], baseline[,3], type = 'l' , col = "white",
     xlab = "N", ylab = "execution time(sec)" , main = "performance comparison (regression)")
abline(baseline_lr, col = "red" , lwd = 2)
abline(omp2_lr, col = "blue" , lwd = 2)
abline(omp4_lr, col = "black" , lwd = 2)
abline(avx_lr, col = "yellow" , lwd = 2)
abline(avx_unroll_lr, col = "green" , lwd = 2)
legend('topleft', # places a legend at the appropriate place 
       c("baseline", "omp2", "omp4","avx","avx_unroll"), # puts text in the legend
       lty=c(1,1,1,1,1), # gives the legend appropriate symbols (lines)
       lwd=c(2.5,2.5,2.5,2.5,2.5),col=c("red","blue", "black","yellow","green"))
dev.off()