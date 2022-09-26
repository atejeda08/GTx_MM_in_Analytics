# -------------------- Code for HW 3 Question 2 -----------------------------
# Clear environment

rm(list = ls())


# Read data
data <- read.table("C:/Users/ateje/OneDrive/Desktop/VS Code Projects/GTx_MM_in_Analytics/R_projects/hw4-SP22/temps.txt", header = TRUE)
data_vec <- as.vector(unlist(data[,2:21]))
data_ts <- ts(data = data_vec, frequency=10, start=1996)
summary(data_ts)

data_ts

components_data_ts <- decompose(data_ts)
plot(components_data_ts)

holt_winters1 <- HoltWinters(data_ts)
holt_winters2 <- HoltWinters(data_ts, alpha = 0.2, beta = 0.1, gamma = 0.1)

plot(holt_winters1)

plot(data_ts, ylab="Temperature", xlim=c(1996,2015))
lines(holt_winters1$fitted[,1], lty=2, col="blue")
lines(holt_winters2$fitted[,1], lty=2, col="red")





# Avg daily temp each year
d_avg  <- colMeans(data[,2:21], na.rm = TRUE)
print(d_avg)

# Trasform to time series
d_avg.ts<-ts(d_avg)
print(d_avg.ts)

# Setting the random number generator seed so that our results are reproducible
# (Your solution doesn't need this, but it's usually good practice to do)

set.seed(1)

# Plot the data.ts

plot.ts(d_avg.ts)

# Exponential Smoothing
d_avg.ts_forecasts<-HoltWinters(d_avg.ts, beta = FALSE, gamma = FALSE)
plot(d_avg.ts_forecasts)

# plot 
plot(d_avg.ts_forecasts)



d_avg.ts_forecasts$fitted

# Forecast

m <- d_avg.ts_forecasts 
p <- predict(m, 5, prediction.interval = TRUE)
plot(m, p)

d_avg.ts_forecasts2<- forecast.HoltWinters(d_avg.ts_forecasts, h=5)


# Plot forecast
plot.forecast(d_avg.ts_forecasts2)
