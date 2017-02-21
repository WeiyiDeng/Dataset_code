setwd("E:/Trans/Transfer from old Toshiba/SQLite")

set.seed(61979)

X <- runif(20)
X <- matrix(X,10,2)
X

epsilon <- rnorm(10)
epsilon

y <- 4 + 2*X[,1] + 3*X[,2] + epsilon

ones <- rep(1,10)
X <- cbind(ones, X)

b <- solve(t(X)%*%X)%*%t(X)%*%y

y_hat <- X%*%b
e <- y-y_hat

SST <- sum((y-mean(y))^2)

R_square <- 1-t(e)%*%e/SST

### to verify with lm
mod <- lm(y~X)
summary(mod)

?summary.lm

# store r squared output from lm 
r_squared_lm <- summary(mod)$r.squared
r_squared_lm


### test list
sth <- list()
sth[[1]] <- c(1,2,3)
sth[[2]] <- NA
sth[[3]] <- coefficients(summary(mod))
sth
### test over

## 
trydata <- read.csv(file="E:/Trans/Transfer from old Toshiba/SQLite/listen_trends_left_join_big.csv", header=TRUE, sep=",")
# trydata <- read.csv(file="E:/Trans/Transfer from old Toshiba/SQLite/listen_trends_left_join.csv", header=TRUE, sep=",")
listen_trend <- trydata[,-2]                     # remove adopt data for now

r_square_vec <- c()
coef_list <- list()
less_row_band <- c()
all_zero_band <- c()
obs_num <- c()
band_name <- c()

from_ind = 1
past_ind = 1
k <- 1
# for (i in 2:29){
for (i in 2:nrow(listen_trend)){
  if (listen_trend[past_ind,6] != listen_trend[i,6]){
    # print(from_ind)
    # print(i-1)
    if (i-from_ind<30){
    # if (i-from_ind<5){
      less_row_band <- c(less_row_band, from_ind)
      print(from_ind)
      print(i-1)
    } else {
      X <- as.matrix(listen_trend[from_ind:(i-1),2:5])
      y <- listen_trend[from_ind:(i-1),1]
      if (sum(sum(X))!=0) {
        X <- X[,apply(X,2,sum)!=0]
        mod <- lm(y~X)
        R_square <- summary(mod)$r.squared
        r_square_vec <- c(r_square_vec, R_square)
        coef_list[[k]] <- coefficients(summary(mod))
        k = k+1
      } else {
        all_zero_band <- c(all_zero_band, from_ind) 
      }
    }
    obs_num <- c(obs_num, i-from_ind)
    band_name <- c(band_name, listen_trend[past_ind,6])
    from_ind = i
    # print(from_ind)
  } else {}
  past_ind = i
  # print(past_ind)
}
# cor_list <- c(cor_list, cor(listen_trend[from_ind:nrow(listen_trend),3],listen_trend[from_ind:nrow(listen_trend),5]))
# add the last band to the vector

band_name <- c(band_name, listen_trend[nrow(listen_trend),6])

length(all_zero_band)
length(less_row_band)
mean(r_square_vec)

hist(obs_num)
min(obs_num)
max(obs_num)
mean(obs_num)

##########################################################
###################### g1+g2+g3+g4 #######################
##########################################################
# gtrends_sum <- apply(listen_trend[,2:5],1,sum)
# gtrends_sum <- listen_trend[,2]
# gtrends_sum <- listen_trend[,3]
# gtrends_sum <- listen_trend[,4]
gtrends_sum <- listen_trend[,5]

cor_list <- c()
one_row_band <- c()
from_ind = 1
past_ind = 1
# for (i in 2:23){
for (i in 2:nrow(listen_trend)){
  if (listen_trend[past_ind,6] != listen_trend[i,6]){
    # print(from_ind)
    # print(i-1)
    cor_list <- c(cor_list, cor(listen_trend[from_ind:(i-1),1],gtrends_sum[from_ind:(i-1)]))
    if (from_ind==(i-1)){
      one_row_band <- c(one_row_band, from_ind)
    }
    print(cor(listen_trend[from_ind:(i-1),1],gtrends_sum[from_ind:(i-1)]))
    from_ind = i
    # print(from_ind)
  } else {
  }
  past_ind = i
  print(past_ind)
}
cor_list <- c(cor_list, cor(listen_trend[from_ind:nrow(listen_trend),1],gtrends_sum[from_ind:nrow(listen_trend)]))
# add the last band to the vector

mean(cor_list,na.rm = TRUE)

cor_distr <- cor_list[!is.na(cor_list)]
max(cor_distr)
min(cor_distr)
median(cor_distr)
mean(cor_distr)
hist(cor_distr, breaks = 20)
sum(cor_distr==1)
# add the last band to the vector


### create new data matrix
###
band_names_prep <- rep(band_name, each = 423)
band_names_prep[2]
band_names_prep[424]

weeks_prep <- rep(1:423, 2588)
weeks_prep[3]
weeks_prep[425]

full_weeks_mat <- cbind(band_names_prep, weeks_prep)

write.csv(file="full_weeks_mat.csv", x=full_weeks_mat)

##################################################################
###################### listen versus trends ######################
##################################################################

rm(list = ls())

# listen_trends_left_join_full_weeks.csv aggregated from listenbandweeks; aggregated listens of 24626 users
trydata <- read.csv(file="E:/Trans/Transfer from old Toshiba/SQLite/listen_trends_left_join_full_weeks.csv", header=TRUE, sep=",")
# trydata <- read.csv(file="E:/Trans/Transfer from old Toshiba/SQLite/listen_trends_left_join.csv", header=TRUE, sep=",")
listen_trend_full <- trydata

r_square_vec <- c()
coef_list <- list()
less_row_band <- c()
all_zero_band <- c()
obs_num <- c()
band_name <- c()

from_ind = 1
past_ind = 1
k <- 1
# for (i in 2:1270){
for (i in 2:nrow(listen_trend_full)){
  if (listen_trend_full[past_ind,6] != listen_trend_full[i,6]){
    # print(from_ind)
    # print(i-1)
      X <- as.matrix(listen_trend_full[from_ind:(i-1),2:5])
      y <- listen_trend_full[from_ind:(i-1),1]
      if (sum(sum(X))!=0) {
        X <- X[,apply(X,2,sum)!=0]
        # mod <- lm(log(y+1)~X)
        mod <- lm(y~X)
        R_square <- summary(mod)$r.squared
        r_square_vec <- c(r_square_vec, R_square)
        coef_list[[k]] <- coefficients(summary(mod))
        k = k+1
      } else {
        all_zero_band <- c(all_zero_band, from_ind)
        r_square_vec <- c(r_square_vec, NA)
      }
    obs_num <- c(obs_num, i-from_ind)
    band_name <- c(band_name, listen_trend_full[past_ind,6])
    from_ind = i
    # print(from_ind)
  } else {}
  past_ind = i
  # print(past_ind)
}
X <- as.matrix(listen_trend_full[from_ind:nrow(listen_trend_full),2:5])
y <- listen_trend_full[from_ind:nrow(listen_trend_full),1]
mod <- lm(y~X)
R_square <- summary(mod)$r.squared
R_square
r_square_vec <- c(r_square_vec, R_square)
band_name <- c(band_name, 6046)
# add the last band to the vector

length(all_zero_band)
length(less_row_band)
mean(r_square_vec, na.rm=TRUE)

all_zeros_band_names <- listen_trend_full[all_zero_band,6]

getdata <- read.csv(file="E:/Trans/Transfer from old Toshiba/SQLite/sum_lis.csv", header=TRUE, sep=",")
total_listen_per_band <- getdata
cor(total_listen_per_band[,2],r_square_vec, use = "na.or.complete")

### check plots listen vs trends
# n <- 151
# n <- 143
n <- 74
# n <- 70
# n <- 40                                                    # the nth number of band; not the original BAND_ID !!
# n = 53                                                     # problem?
# total_listen_per_band[n,1]                                 # gets BAND_ID
# n = 2588
start_week <- (n-1)*423+1
end_week <- n*423
X <- as.matrix(listen_trend_full[start_week:end_week,2:5])
y <- listen_trend_full[start_week:end_week,1]

plot(X[,1], type="l",col="red",ylim = c(1,100))                           # original
lines(X[,2], type="l",col="blue")                                         # cat3    arts & entertainment
lines(X[,3], type="l",col="orange")                                        # cat35   music & audio
lines(X[,4], type="l",col="yellow")                                       # label
scale_factor <- 100/max(y)
std_y <- y*scale_factor
lines(std_y,col="green")

r_square_vec[n]
# band_name[n]
y

# which.max(X[,1])
# X[217,1]


# coef_list[[1]]
coef_list[[1]]["Xtrend_ori",1]


# ----------------- test tryCatch -----------------------
test_list <- list(a = NULL, b = "some_value")
some_list <- c()
err <- c()
for(i in 1:4){
  obj <- tryCatch({
    x <- test_list[[i]]
    x <- ifelse(is.null(x), NA, x)
  }
  , error = function(e) {err <<- c(err,e$message)},                        # double arrow allows to change value of a variable two levels above
  finally = print("sth"))
  print(obj)
}
err
#------------------ test over ----------------------------

coeff_ori <- c()
coeff_cat3 <- c()
coeff_cat35 <- c()
coeff_lab <- c()
err <- c()
warn <- c()
for (i in 1:length(coef_list)){
  obj <- tryCatch(
    {coeff_ori <- c(coeff_ori, coef_list[[i]]["Xtrend_ori",1])
    coeff_cat3 <- c(coeff_cat3, coef_list[[i]]["Xtrend_cat3",1])
    coeff_cat35 <- c(coeff_cat35, coef_list[[i]]["Xtrend_cat35",1])
    coeff_lab <- c(coeff_lab, coef_list[[i]]["Xtrend_lab",1])},
    error = function(e) {err <<- c(err,e$message)},
    warnings = function(w) {warn <<- c(warn,w$message)}
    )
}
print(err)

hist(coeff_ori,breaks = 50)
hist(coeff_cat3,breaks = 50)
hist(coeff_cat35,breaks = 50)
hist(coeff_lab,breaks = 50)

# large coeff outliers

###########################################################
###################### adopt vs trends ####################
###########################################################

rm(list = ls())

# listen_trends_left_join_full_weeks.csv aggregated from listenbandweeks; aggregated listens of 24626 users
trydata <- read.csv(file="E:/Trans/Transfer from old Toshiba/SQLite/adopt_trends_left_join_full_weeks.csv", header=TRUE, sep=",")
# trydata <- read.csv(file="E:/Trans/Transfer from old Toshiba/SQLite/listen_trends_left_join.csv", header=TRUE, sep=",")
adopt_trend_full <- trydata

r_square_vec <- c()
coef_list <- list()
less_row_band <- c()
all_zero_band <- c()
obs_num <- c()
band_name <- c()

from_ind = 1
past_ind = 1
k <- 1
# for (i in 2:1270){
for (i in 2:nrow(adopt_trend_full)){
  if (adopt_trend_full[past_ind,6] != adopt_trend_full[i,6]){
    # print(from_ind)
    # print(i-1)
    X <- as.matrix(adopt_trend_full[from_ind:(i-1),2:5])
    y <- adopt_trend_full[from_ind:(i-1),1]
    if ((sum(sum(X))!=0) & (sum(y)!=0)) {
      X <- X[,apply(X,2,sum)!=0]
      mod <- lm(y~X)
      R_square <- summary(mod)$r.squared
      r_square_vec <- c(r_square_vec, R_square)
      coef_list[[k]] <- coefficients(summary(mod))
      k = k+1
    } else {
      all_zero_band <- c(all_zero_band, from_ind)
      r_square_vec <- c(r_square_vec, NA)
    }
    obs_num <- c(obs_num, i-from_ind)
    band_name <- c(band_name, adopt_trend_full[past_ind,6])
    from_ind = i
    # print(from_ind)
  } else {}
  past_ind = i
  # print(past_ind)
}
X <- as.matrix(adopt_trend_full[from_ind:nrow(adopt_trend_full),2:5])
y <- adopt_trend_full[from_ind:nrow(adopt_trend_full),1]
mod <- lm(y~X)
R_square <- summary(mod)$r.squared
R_square
r_square_vec <- c(r_square_vec, R_square)
band_name <- c(band_name, 6046)
# add the last band to the vector

length(all_zero_band)
length(less_row_band)
mean(r_square_vec, na.rm=TRUE)

all_zeros_band_names <- adopt_trend_full[all_zero_band,6]


######################################################################
###################### adopt vs trends with lags #####################
######################################################################

rm(list = ls())

# strict adoption definition:
# if data of user i includes intro date of band j
# count as adoption

trydata <- read.csv(file="E:/Trans/Transfer from old Toshiba/SQLite/adopt_strict_trends_left_join_full_weeks.csv", header=TRUE, sep=",")
# listen_trends_left_join_full_weeks.csv aggregated from listenbandweeks; aggregated listens of 24626 users
# trydata <- read.csv(file="E:/Trans/Transfer from old Toshiba/SQLite/adopt_trends_left_join_full_weeks.csv", header=TRUE, sep=",")
# trydata <- read.csv(file="E:/Trans/Transfer from old Toshiba/SQLite/listen_trends_left_join.csv", header=TRUE, sep=",")
adopt_trend_full <- trydata

r_square_vec <- c()
coef_list <- list()
less_row_band <- c()
all_zero_band <- c()
obs_num <- c()
band_name <- c()
y_sum <- c()

from_ind = 1
past_ind = 1
k <- 1
lag <- 0
# for (i in 2:1693){
for (i in 2:nrow(adopt_trend_full)){
  if (adopt_trend_full[past_ind,6] != adopt_trend_full[i,6]){
    # print(from_ind)
    # print(i-1)
    X <- as.matrix(adopt_trend_full[from_ind:(i-1),2:5])
    y <- adopt_trend_full[from_ind:(i-1),1]
    if ((sum(sum(X))!=0) & (sum(y)!=0)) {
      X <- X[,apply(X,2,sum)!=0]
      if (class(X)=="matrix"){
        size_X = nrow(X)
        X_trun <- X[(lag+1):size_X,]
        X_lags <- X[1:(size_X-lag),]
      } else {
        size_X = length(X)
        X_trun <- X[(lag+1):size_X]
        X_lags <- X[1:(size_X-lag)]
      }
      y_lag <- y[(lag+1):length(y)]
      # X_cbind <- cbind(X_trun, X_lags)
      # mod <- lm(y_lag~X_trun + X_lags)                      # model with lag(s)
      mod <- lm(y_lag~X_trun)                                 # turn off lag(s)
      R_square <- summary(mod)$r.squared
      r_square_vec <- c(r_square_vec, R_square)
      y_sum <- c(y_sum, sum(y))
      coef_list[[k]] <- coefficients(summary(mod))
      k = k+1
    } else {
      all_zero_band <- c(all_zero_band, from_ind)
      r_square_vec <- c(r_square_vec, NA)
      y_sum <- c(y_sum, NA)
    }
    obs_num <- c(obs_num, i-from_ind)
    band_name <- c(band_name, adopt_trend_full[past_ind,6])
    from_ind = i
    # print(from_ind)
  } else {}
  past_ind = i
  # print(past_ind)
}
X <- as.matrix(adopt_trend_full[from_ind:nrow(adopt_trend_full),2:5])
y <- adopt_trend_full[from_ind:nrow(adopt_trend_full),1]
y_sum <- c(y_sum, sum(y))
mod <- lm(y~X)
R_square <- summary(mod)$r.squared
R_square
r_square_vec <- c(r_square_vec, R_square)
band_name <- c(band_name, 6046)
# add the last band to the vector

length(all_zero_band)
length(less_row_band)                       # each band has 423 rows, no less row band here
mean(r_square_vec, na.rm=TRUE)

all_zeros_band_names <- adopt_trend_full[all_zero_band,6]


### check plots adopt vs trends
# n <- 151
# n <- 143

n <- 185
# n <- 70
# n <- 40                                                    # the nth number of band; not the original BAND_ID !!
# n = 53                                                     # problem?
# total_listen_per_band[n,1]                                 # gets BAND_ID
# n = 2588
start_week <- (n-1)*423+1
end_week <- n*423
X <- as.matrix(adopt_trend_full[start_week:end_week,2:5])
y <- adopt_trend_full[start_week:end_week,1]

plot(X[,1], type="l",col="red",ylim = c(1,100))                           # original
lines(X[,2], type="l",col="blue")                                         # cat3    arts & entertainment
lines(X[,3], type="l",col="orange")                                        # cat35   music & audio
lines(X[,4], type="l",col="yellow")                                       # label
scale_factor <- 100/max(y)
std_y <- y*scale_factor
lines(std_y,col="green")

r_square_vec[n]
# band_name[n]
y

sum(is.na(r_square_vec))                                                 # number of NAs in R squared vector
# r_square_vec[2543]

###############################################
############ plot low r_square bands ##########
###############################################

hist(y_sum, breaks = 50)
plot(y_sum[y_sum < 500],r_square_vec[y_sum < 500])
plot(y_sum[y_sum > 400 & r_square_vec<0.1],r_square_vec[y_sum > 400 & r_square_vec<0.1])

low_r_square_big_bands <- which(y_sum > 400 & r_square_vec<0.2)
high_r_square_big_bands <- which(y_sum > 400 & r_square_vec>0.8)

sum(y_sum>50, na.rm=TRUE)
mean(r_square_vec[y_sum>50],na.rm=TRUE)

trydata <- read.csv(file="E:/Trans/Transfer from old Toshiba/SQLite/member_adoptions_per_band_with_model_data.csv", header=TRUE, sep=",")
# trydata <- read.csv(file="E:/Trans/Transfer from old Toshiba/SQLite/member_adoption_per_band_all_users_data.csv", header=TRUE, sep=",")
member_adopt <- trydata[,1]

b <- c(0, 0.3, 0.6, 1)
r_square_cut <- cut(r_square_vec, breaks = b)
table(member_adopt,r_square_cut)

#------------------------ plot share of all adoptions vs R squared ----------------------------
threshold <- 0.05
sum_member_adopt <- c()
add_up <- 0

while (add_up < 1) {
  sum_member_adopt <- c(sum_member_adopt, sum(member_adopt[r_square_vec>add_up & r_square_vec<add_up+threshold], na.rm=TRUE))
  add_up <- add_up+threshold
}
plot(cumsum(sum_member_adopt)/sum(sum_member_adopt), type = "h", 
     xlab = "r_square", ylab = "sum_adoptions", xaxt='n', main = "share of all adoptions vs R squared")
labels <- seq(threshold,1,threshold)
axis(1, 1:length(labels), labels)
#----------------------------------------------------------------------------------------------

#------------------------ plot all low r square big bands -------------------------------------
trydata2 <- read.csv(file="E:/Trans/Transfer from old Toshiba/SQLite/newbandlist2588.csv", header=TRUE, sep=",")
new_band_names <- trydata2

for (i in 1:length(low_r_square_big_bands)){
  n <- low_r_square_big_bands[i]
  # n <- 70
  # n <- 40                                                    # the nth number of band; not the original BAND_ID !!
  # n = 53                                                     # problem?
  # total_listen_per_band[n,1]                                 # gets BAND_ID
  # n = 2588
  start_week <- (n-1)*423+1
  end_week <- n*423
  X <- as.matrix(adopt_trend_full[start_week:end_week,2:5])
  y <- adopt_trend_full[start_week:end_week,1]
  
  plot(X[,1], type="l",col="red",ylim = c(1,100),main=new_band_names[n,2])                           # original
  lines(X[,2], type="l",col="blue")                                         # cat3    arts & entertainment
  lines(X[,3], type="l",col="orange")                                        # cat35   music & audio
  lines(X[,4], type="l",col="yellow")                                       # label
  scale_factor <- 100/max(y)
  std_y <- y*scale_factor
  lines(std_y,col="green")
  
  r_square_vec[n]
  # band_name[n]
  y
}
# ---------------------------------------------------------------------------------------------

### check the names of low_r_square_big_bands with seasonal patterns in search trends
# 961 Hockey
# 973 Hospitality
# 981 Houses

### exclude periods with not enough data to estimate
hist(y_sum[y_sum < 20], breaks = 50)
sum(y_sum < 20, na.rm = TRUE)
