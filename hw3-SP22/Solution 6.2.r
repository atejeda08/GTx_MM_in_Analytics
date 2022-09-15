setwd("C:/Users/jtejeda/OneDrive - Clarios/Documents/R_projects/hw3-SP22")

temp_data <- read.table("temps.txt", stringsAsFactors = FALSE, header = T)
head(temp_data)

#compute daily averages across the years
daily_average <- rowMeans(temp_data[c(2:length(temp_data))], dims=1, na.rm=T)

# calculate mu of the daily averages. This will be used to compute the comulative sums # nolint
mu <- mean(daily_average)

# compute the difference between the mean of the time series and each "day"
#da_minus_mu <- date_avgs - da_mu

# Set an arbitrary C that will be used to calibrate the sensitivity of the model
C <- 0

# calculate the sum of each individual x_t
S_sub_t <- daily_average - mu - C

# create an empty vector for looping
# include an additional zero to help with indexing
preCUSUM <- 0 * S_sub_t
cusum <- append(preCUSUM, 0)

# loop through each day (i) to calculate the CUSUM (S_sub_t) and
# update the accumulator. The below loop is assigning a value to the accumulator 
# variable which is in turn carried onto the next iteration (or not) via the ifelse statement 

for (i in 1:length(S_sub_t)) 
     {
  accumulator <- cusum[i] + S_sub_t[i]
  ifelse(accumulator > 0, cusum[i+1] <- accumulator, cusum[i+1] <- 0)}

plot(cusum)

#This finds the max value on the cumsum graph. 
cummax(cusum)
temp_data[78,1]

#Results of when "the summer unofficially ends" based on different values of C
#August 24 @ C=5
#August 30 @ C=4
#Sept 13 @ C=1
#Sept 16 @ C=0
