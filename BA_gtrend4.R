rm(list = ls())

setwd("E:/Trans/Transfer from old Toshiba/SQLite")

library("dplyr")
library("ggplot2")
library("RSQLite")

db <- src_sqlite("dbaf.db")          # link with database db_mod
db_tba1 <- tbl(db, "newbandlist")          # link with table dataset1
db_tba2 <- tbl(db, "small_bands_names")          # link with table dataset1

take_small_bandlist <- tbl(db,sql("select * from small_bands_names"))
small_bandlist <- collect(take_small_bandlist)

# import manually downladed csv from google trends
trydata <- read.csv(file="E:/Trans/Transfer from old Toshiba/FileProcess/bands2588_lab/4_lab.csv", 
                    header=TRUE, sep=",")
month_trend <- as.numeric(trydata[2:156,1])


### -----------------------------------------------------------------------------
### ----------------- example of spurious corr ----------------------------------
### -----------------------------------------------------------------------------

library(MASS)

set.seed(401716)
sigma <- matrix(c(1,0.7,0.7,1),nrow = 2)                   # set covariance matrix
mu <- c(0,2)                                               # set means
mysimu <- mvrnorm(10,mu,sigma)                              # simulate mvn

cor(mysimu[,1],mysimu[,2])
cor.test(mysimu[,1],mysimu[,2])

x <- mysimu[,1]
y <- mysimu[,2]
cor(x,y)
# plot(ind, x, type="p",col="red")
# points(ind, y, col= "green")

ind <- sample(10, 10, replace = FALSE, prob = NULL)
matplot(ind, cbind(x,y),type="p",col=c("red","green"))

# append another trend to x and y respectively 
sigma <- matrix(c(1,0.3,0.3,1),nrow = 2)                  
mu <- c(11,20)                                           # both have higher mean than the previous series             
# mu <- c(2,3)                                            
# mu <- c(0,2)               # try different means for the second time series to see the difference in final corr
mysimu <- mvrnorm(10,mu,sigma)                           

cor(mysimu[,1],mysimu[,2])
cor.test(mysimu[,1],mysimu[,2])

x <- c(x,mysimu[,1])
y <- c(y,mysimu[,2])

cor(x,y)                                                # now the correlation is very high because of simultaneous changing means
ind <- sample(20, 20, replace = FALSE, prob = NULL)
matplot(ind, cbind(x,y),type="p",col=c("red","green"))

### -----------------------------------------------------------------------------------
### ------------------------------ end of example -------------------------------------
### -----------------------------------------------------------------------------------


# export_list.csv produced from export_prob_stop_lists.py from VM
# get bands in problem and stopped lists
trydata <- read.csv(file="E:/Trans/Transfer from old Toshiba/FileProcess/bands2588_lab/export_list.csv", header=FALSE, sep=",")
# trydata
except_list <- as.numeric(trydata)
except_list

week_trend_mat <- matrix(NA, nrow = 527, ncol = 2588)
for (i in 1:2588) {
  if (i %in% except_list){
  } else {
    print(i)
    path = paste("E:/Trans/Transfer from old Toshiba/FileProcess/bands2588_lab/", i, "_lab.csv", sep = "")
    trend_data <- read.csv(file=path, header=TRUE, sep=",")
    month_trend <- trend_data[,2]
    trun_month <- month_trend[8:143]
    # week_trend <- spline(1:136, trun_month, 588)
    # week_gtrend <- week_trend$y[29:555]
    week_trend_trans <- spline(1:136, log(trun_month+1), 588)               # use log transform then exp to get rid of smaller than 0 values
    week_trend <- exp(week_trend_trans$y)
    week_gtrend <- week_trend[29:555]
    week_trend_mat[,i] <- week_gtrend
    }
}
sum(week_trend_mat<0,na.rm=TRUE)
mean(week_trend_mat, na.rm = TRUE)

# test
mymat <- matrix(1:9, 3, 3)
mymat
matrix(mymat,nrow = 9)

rep(c(1,2,3),times=3)

rep(c(1,2,3),each=3)
# test over

# get the bands not on problem list or stopped list
x <- 1:2588
white_list <- x[!x%in%except_list]


week_trends <- week_trend_mat[,colSums(!is.na(week_trend_mat)) > 0]
week_trends_vec <- matrix(week_trends, nrow = ncol(week_trends)*nrow(week_trends))


# get the real BAND_IDs for the bands on the list
real_band_ids <- rep(0,length(white_list))
for (r in 1:length(white_list)){
  real_band_num <- small_bandlist$BAND_ID[white_list[r]]
  real_band_ids[r] <- real_band_num
}


weeks_vec <- rep(1:527, times = ncol(week_trends))
bands_num_vec <- rep(real_band_ids, each = 527)
weeks_vec[527]
weeks_vec[528]
bands_num_vec[527]
bands_num_vec[528]
bands_num_vec[529]

gtrends_mat <- cbind(bands_num_vec, weeks_vec, week_trends_vec)
head(gtrends_mat)

write.csv(file="gtrends_lab.csv", x=gtrends_mat)

# remove first 104 weeks !!!
gtrends_423 <- cbind(bands_num_vec, weeks_vec-104, week_trends_vec)
head(gtrends_423)
keep_ind <- gtrends_423[,2]>=1
gtrends_mod <- gtrends_423[keep_ind,]
head(gtrends_mod)

write.csv(file="gtrends_lab_423.csv", x=gtrends_mod)

sum(gtrends_mod[,3]<0)                                     # many interpolated values smaller than 0

# merge listens and trends in sql (change column names in Emeditor) 
# import merged listens and trends
trydata <- read.csv(file="E:/Trans/Transfer from old Toshiba/SQLite/listens_vs_trends423_lab.csv", header=TRUE, sep=",")
listen_trend <- trydata[,1:5]

cor(listen_trend[,3],listen_trend[,5])
# cor(listen_trend[,4],listen_trend[,5])

cor_list = NA
one_row_band = NA
from_ind = 1
past_ind = 1
# for (i in 2:23){
for (i in 2:nrow(listen_trend)){
  if (listen_trend[past_ind,1] != listen_trend[i,1]){
    # print(from_ind)
    # print(i-1)
    cor_list <- c(cor_list, cor(listen_trend[from_ind:(i-1),3],listen_trend[from_ind:(i-1),5]))
    if (from_ind==(i-1)){
      one_row_band <- c(one_row_band, from_ind)
    }
    print(cor(listen_trend[from_ind:(i-1),3],listen_trend[from_ind:(i-1),5]))
    from_ind = i
    # print(from_ind)
  } else {
  }
  past_ind = i
  print(past_ind)
}
cor_list <- c(cor_list, cor(listen_trend[from_ind:nrow(listen_trend),3],listen_trend[from_ind:nrow(listen_trend),5]))
# add the last band to the vector

cor_list <- cor_list[-1]                           # remove first element NA from the vector
one_row_band <- one_row_band[-1]

mean(cor_list,na.rm = TRUE)

cor_distr <- cor_list[!is.na(cor_list)]
max(cor_distr)
min(cor_distr)
median(cor_distr)
hist(cor_distr, breaks = 20)
sum(cor_distr==1)

# try scale listens of a band to have max 100
cor(listen_trend[3:22,3],listen_trend[3:22,5])

gtrend <- listen_trend[3:22,5]
lis <- listen_trend[3:22,3]
scale_factor <- 100/max(lis)
std_lis <- lis*scale_factor
std_lis
cor(std_lis, gtrend)

# scale all bands separately
scale_listens = NA
from_ind = 1
past_ind = 1
# for (i in 2:23){
for (i in 2:nrow(listen_trend)){
  if (listen_trend[past_ind,1] != listen_trend[i,1]){
    # print(from_ind)
    # print(i-1)
    band_listen <- listen_trend[from_ind:(i-1),3]
    scale_factor <- 100/max(band_listen)
    band_lis_scaled <- band_listen*scale_factor
    scale_listens <- c(scale_listens, band_lis_scaled)
    from_ind = i
    # print(from_ind)
  } else {
  }
  past_ind = i
  print(past_ind)
}
band_listen <- listen_trend[from_ind:nrow(listen_trend),3]
scale_factor <- 100/max(band_listen)
band_lis_scaled <- band_listen*scale_factor
scale_listens <- c(scale_listens, band_lis_scaled)
# add the last band to the vector

scale_listens <- scale_listens[-1]                        # remove first element NA from the vector

scale_listens_rm <- scale_listens[-one_row_band]          # remove bands with only one observation
gtrend_rm <- listen_trend[,5]
gtrend_rm <- gtrend_rm[-one_row_band]
cor(scale_listens_rm, gtrend_rm)                          # get the corr of all bands all at once after standardizing listening data for each band

