# try using ridge regression to get rid of large coefficients

rm(list = ls())

setwd("E:/Trans/Transfer from old Toshiba/SQLite")

library(MASS)

#j <- 0
#for (i in 1:100) {
##  browser()
#  j = j+i
#}
#print(j)

# strict adoption definition:
# if data of user i includes intro date of band j
# count as adoption

# adopt_strict_trends_left_join_full_weeks2 fixed the trend_cat3 < 0 values
trydata <- read.csv(file="E:/Trans/Transfer from old Toshiba/SQLite/adopt_strict_trends_left_join_full_weeks_4061.csv", header=TRUE, sep=",")
# listen_trends_left_join_full_weeks.csv aggregated from listenbandweeks; aggregated listens of 24626 users
# trydata <- read.csv(file="E:/Trans/Transfer from old Toshiba/SQLite/adopt_trends_left_join_full_weeks.csv", header=TRUE, sep=",")
# trydata <- read.csv(file="E:/Trans/Transfer from old Toshiba/SQLite/listen_trends_left_join.csv", header=TRUE, sep=",")
adopt_trend_full <- trydata
summary(adopt_trend_full)

sum(adopt_trend_full<0)                                         # check if exists any trend values smaller than 0 
# adopt_trend_full[adopt_trend_full<0] <- 0                       # simply set all smaller than 0 values to 0

r_square_vec <- c()
coef_list <- list()
less_row_band <- c()
all_zero_band <- c()
obs_num <- c()
band_name <- c()
y_sum <- c()
avg_cor <- c()
num_trends <- c()
cut_row <- c()

from_ind = 1
past_ind = 1
# from_ind = 1404784
# past_ind = 1404784
k <- 1
lag <- 0
empty_bands_count <- 0
# for (i in 2:1693){
# for (i in 1404785:nrow(adopt_trend_full)) {
  # print(i)
for (i in 2:nrow(adopt_trend_full)){
  if (adopt_trend_full[past_ind,6] != adopt_trend_full[i,6]){
    # print('stop here')
    # print(from_ind)
    # print(i-1)
    band_rows <- adopt_trend_full[from_ind:(i-1),]
    # print(dim(band_rows))
    for (j in 1:nrow(band_rows)){
      # if (sum(band_rows[1:j,1])/j>0.05){                
      if (sum(band_rows[,1])/j>0.1){                     # more then 10% adoptions
        break
      }
    }
    # print(nrow(band_rows))
    if (j>20 && j<nrow(band_rows)){                    # large band and more then 10% adoptions
      # band_rows <- band_rows[j:nrow(band_rows),]       # w: ???     want to include only obs with more than 10% adoption?
      X <- as.matrix(band_rows[,2:5])
      y <- as.matrix(band_rows[,1])
      skip_flag <- 0
    } else if (j==nrow(band_rows)) {                   # large band but less then 10% adoptions
      band_rows <- c()
      X<- c()
      y <- c()
      skip_flag <- 1
      # print('large band but less then 10% adoptions')
    } else {                                          # small band but more then 10% adoptions
      skip_flag <- 0
      X <- as.matrix(band_rows[,2:5])
      y <- as.matrix(band_rows[,1])
    }
    # print(sum(sum(X)))
    # print(skip_flag)
    # print(dim(band_rows))
    # print(dim(X))
    # print(dim(y))
    # X <- as.matrix(adopt_trend_full[from_ind:(i-1),2:5])
    # y <- adopt_trend_full[from_ind:(i-1),1]
    if ((sum(sum(X))!=0) && (sum(y)!=0) && (skip_flag != 100)) {            # not using skip_flag, include all bands, but values of x and y have been changed by previous steps anyway
      X <- X[,apply(X,2,sum)!=0]                                            # remove all zero trend columns
      if (class(X)=="matrix"){
        size_X = nrow(X)
        X_trun <- X[(lag+1):size_X,]
        X_lags <- X[1:(size_X-lag),]
        cor_trends_mat <- cor(X_trun)
        cor_trend <- mean(cor_trends_mat[cor_trends_mat!=1])
        num_of_trends <- ncol(X_trun)
        cut_row <- c(cut_row, (423-nrow(X_trun)+1))
        # browser()
      } else {                                             # for bands with only one trend ! not empty bands !!
        size_X = length(X)
        X_trun <- X[(lag+1):size_X]
        X_lags <- X[1:(size_X-lag)]
        cor_trend <- NA
        num_of_trends <- 1
        cut_row <- c(cut_row, (423-length(X_trun)+1))
      }
      y_lag <- y[(lag+1):length(y)]
      # X_cbind <- cbind(X_trun, X_lags)
      # mod <- lm(y_lag~X_trun + X_lags)
      # print('landmark')
      # print(dim(X_trun))
      # print(length(y_lag))
      X_trun <- log(X_trun+1)                          # log on both sides of the equation
      if (class(X_trun)=="matrix") {
        mod <- lm.ridge(log(y_lag+1)~X_trun, lambda = 100)               # try ridge regression; log on both sides of the equation
        coef_list[[k]] <- coef(mod)                        # get coeff from lm.ridge
      } else {
        # X_trun <- X_trun*100
        mod <- lm(log(y_lag+1)~X_trun)                     # log on both sides of the equation
        coef_list[[k]] <- coefficients(summary(mod))
      }
      # cut_row <- c(cut_row, 1)          # debug
      # R_square <- summary(mod)$r.squared
      # r_square_vec <- c(r_square_vec, R_square)
      y_sum <- c(y_sum, sum(y))
      avg_cor <- c(avg_cor, cor_trend)
      num_trends <- c(num_trends, num_of_trends)
      k = k+1
    # } else if ((sum(sum(X))==0) || (sum(y)==0)) {
    } else {                                              # this is actually for both empty bands and all zero bands, as empty bands with X <- c() also have sum(X)==0 ....
      all_zero_band <- c(all_zero_band, from_ind)
      if (length(X)==0) {empty_bands_count = empty_bands_count+1}             # this is to count the number of empty bands
      # r_square_vec <- c(r_square_vec, NA)
      y_sum <- c(y_sum, NA)
      avg_cor <- c(avg_cor, NA)
      num_trends <- c(num_trends, NA)
      cut_row <- c(cut_row, NA)
    }
    obs_num <- c(obs_num, i-from_ind)
    band_name <- c(band_name, adopt_trend_full[past_ind,6])
    from_ind = i
    # print(from_ind)
  } else {}
  past_ind = i
#  browser()
  # print(past_ind)
}
X <- as.matrix(adopt_trend_full[from_ind:nrow(adopt_trend_full),2:4])
y <- adopt_trend_full[from_ind:nrow(adopt_trend_full),1]
y_sum <- c(y_sum, sum(y))
X <- log(X+1)
# mod <- lm(log(y+1)~X)
mod <- lm.ridge(log(y+1)~X, lambda = 1)                                   # try ridge regression
# R_square <- summary(mod)$r.squared
# R_square
# r_square_vec <- c(r_square_vec, R_square)
band_name <- c(band_name, 6046)
cut_row <- c(cut_row, (423-length(X_trun)+1))
# coef_list[[k]] <- coefficients(summary(mod))
coef_list[[k]] <- coef(mod)                                  # get coeff from lm.ridge

cor_trends_mat <- cor(X)
cor_trend <- mean(cor_trends_mat[cor_trends_mat!=1])
avg_cor <- c(avg_cor, cor_trend)
num_trends <- c(num_trends, ncol(X)) 
# add the last band to the vector

length(all_zero_band)
length(less_row_band)                       # each band has 423 rows, no less row band here
# mean(r_square_vec, na.rm=TRUE)

all_zeros_band_names <- adopt_trend_full[all_zero_band,6]

sum(!is.na(avg_cor))
hist(avg_cor, breaks = 50)
mean(avg_cor, na.rm=TRUE)

print(empty_bands_count)                    # w: almost 1/3 of bands are empty bands by the criteria set above !
                                            # w: these empty bands use baseline probability instead of trends data for the model, potentially leads to insignificant problem?

# plot(avg_cor, r_square_vec)

# low_r_square_low_avg_cor <- which(avg_cor < 0.2 & r_square_vec<0.2)

# trydata2 <- read.csv(file="E:/Trans/Transfer from old Toshiba/SQLite/newbandlist2588.csv", header=TRUE, sep=",")
# new_band_names <- trydata2

# low_r_square_low_avg_cor_band_names <- new_band_names[low_r_square_low_avg_cor,]
# num_trends_temp <- num_trends[low_r_square_low_avg_cor]
# cbind(low_r_square_low_avg_cor_band_names, num_trends_temp)

# sum(is.na(r_square_vec))                                                 # number of NAs in R squared vector
# r_square_vec[2543]

###################################################################################################################
################################################## ignore #########################################################
###################################################################################################################

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
# trydata2 <- read.csv(file="E:/Trans/Transfer from old Toshiba/SQLite/newbandlist2588.csv", header=TRUE, sep=",")
# new_band_names <- trydata2

for (i in 1:length(low_r_square_big_bands)){
# for (i in 157){                                                # band 2543
  n <- low_r_square_big_bands[i]
  # n <- 70
  # n <- 40                                                    # the nth number of band; not the original BAND_ID !!
  # n = 53                                                     # problem?
  # total_listen_per_band[n,1]                                 # gets BAND_ID
  # n = 2588
  start_week <- (n-1)*423+1
  end_week <- n*423
  band_rows_X <- adopt_trend_full[start_week:end_week,2:5]
  band_rows_y <- adopt_trend_full[start_week:end_week,1]
  if (!is.na(cut_row[n])){
    X <- as.matrix(band_rows_X[cut_row[n]:423,])
    y <- band_rows_y[cut_row[n]:423]
  } else{
    X <- as.matrix(band_rows_X)
    y <- band_rows_y
    new_band_names[n,2]
  }
  # print(dim(X))
  plot(X[,1], type="l",col="red",ylim = c(1,100),main=paste(n,new_band_names[n,2]))                           # original
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

#########################################################################################################
############################################# ignore ends ###############################################
#########################################################################################################


##################################################################################
########### collect coefficients of non-zeros bands from coef_list ###############
##################################################################################

# ----------- check which coefficients of trend exist for non-zeros bands from coef_list -----------------

coeff_ori <- c()
err <- c()
warn <- c()
ori_list <- c()
for (i in 1:length(coef_list)){
  temp1 <- NULL
  # temp2 <- NULL
  # temp3 <- NULL
  # temp4 <- NULL
  obj <- tryCatch(
    {coeff_ori <- c(coeff_ori, coef_list[[i]][2])
    #coeff_ori <- c(coeff_ori, coef_list[[i]]["X_truntrend_ori",1])
    #coeff_cat3 <- c(coeff_cat3, coef_list[[i]]["X_truntrend_cat3",1])
    #coeff_cat35 <- c(coeff_cat35, coef_list[[i]]["X_truntrend_cat35",1])
    #coeff_lab <- c(coeff_lab, coef_list[[i]]["X_truntrend_lab",1])
    temp1 <- coef_list[[i]][2]
    # temp1 <- coef_list[[i]]["X_truntrend_ori",1]
    #temp2 <- coef_list[[i]]["X_truntrend_cat3",1]
    #temp3 <- coef_list[[i]]["X_truntrend_cat35",1]
    #temp4 <- coef_list[[i]]["X_truntrend_lab",1]
    },
    error = function(e) {err <<- c(err,e$message)},
    warnings = function(w) {warn <<- c(warn,w$message)},
    finally = {
      # exist_list[[i]] <- c(exist_list[[i]], is.null(temp1))
      ori_list <- c(ori_list,!is.null(temp1))
    }
  )
}
print(err)
ori_list <- as.numeric(ori_list)

#
coeff_cat3 <- c()
err <- c()
warn <- c()
cat3_list <- c()
for (i in 1:length(coef_list)){
  # temp1 <- NULL
  temp2 <- NULL
  # temp3 <- NULL
  # temp4 <- NULL
  obj <- tryCatch(
    {
      # coeff_ori <- c(coeff_ori, coef_list[[i]]["X_truntrend_ori",1])
    coeff_cat3 <- c(coeff_cat3, coef_list[[i]][3])
    #coeff_cat35 <- c(coeff_cat35, coef_list[[i]]["X_truntrend_cat35",1])
    #coeff_lab <- c(coeff_lab, coef_list[[i]]["X_truntrend_lab",1])
    # temp1 <- coef_list[[i]]["X_truntrend_ori",1]
    temp2 <- coef_list[[i]][3]
    #temp3 <- coef_list[[i]]["X_truntrend_cat35",1]
    #temp4 <- coef_list[[i]]["X_truntrend_lab",1]
    },
    error = function(e) {err <<- c(err,e$message)},
    warnings = function(w) {warn <<- c(warn,w$message)},
    finally = {
      # exist_list[[i]] <- c(exist_list[[i]], is.null(temp1))
      # ori_list <- c(ori_list,!is.null(temp1))
      cat3_list <- c(cat3_list,!is.null(temp2))
    }
  )
}
print(err)
cat3_list <- as.numeric(cat3_list)

#
coeff_cat35 <- c()
err <- c()
warn <- c()
cat35_list <- c()
for (i in 1:length(coef_list)){
  # temp1 <- NULL
  # temp2 <- NULL
  temp3 <- NULL
  # temp4 <- NULL
  obj <- tryCatch(
    {
      # coeff_ori <- c(coeff_ori, coef_list[[i]]["X_truntrend_ori",1])
      # coeff_cat3 <- c(coeff_cat3, coef_list[[i]]["X_truntrend_cat3",1])
      coeff_cat35 <- c(coeff_cat35, coef_list[[i]][4])
      #coeff_lab <- c(coeff_lab, coef_list[[i]]["X_truntrend_lab",1])
      # temp1 <- coef_list[[i]]["X_truntrend_ori",1]
      # temp2 <- coef_list[[i]]["X_truntrend_cat3",1]
      temp3 <- coef_list[[i]][4]
      #temp4 <- coef_list[[i]]["X_truntrend_lab",1]
    },
    error = function(e) {err <<- c(err,e$message)},
    warnings = function(w) {warn <<- c(warn,w$message)},
    finally = {
      # exist_list[[i]] <- c(exist_list[[i]], is.null(temp1))
      # ori_list <- c(ori_list,!is.null(temp1))
      cat35_list <- c(cat35_list,!is.null(temp3))
    }
  )
}
print(err)
cat35_list <- as.numeric(cat35_list)


#
coeff_lab <- c()
err <- c()
warn <- c()
lab_list <- c()
for (i in 1:length(coef_list)){
  # temp1 <- NULL
  # temp2 <- NULL
  # temp3 <- NULL
  temp4 <- NULL
  obj <- tryCatch(
    {
      # coeff_ori <- c(coeff_ori, coef_list[[i]]["X_truntrend_ori",1])
      # coeff_cat3 <- c(coeff_cat3, coef_list[[i]]["X_truntrend_cat3",1])
      # coeff_cat35 <- c(coeff_cat35, coef_list[[i]]["X_truntrend_cat35",1])
      coeff_lab <- c(coeff_lab, coef_list[[i]][5])
      # temp1 <- coef_list[[i]]["X_truntrend_ori",1]
      # temp2 <- coef_list[[i]]["X_truntrend_cat3",1]
      # temp3 <- coef_list[[i]]["X_truntrend_cat35",1]
      temp4 <- coef_list[[i]][5]
    },
    error = function(e) {err <<- c(err,e$message)},
    warnings = function(w) {warn <<- c(warn,w$message)},
    finally = {
      # exist_list[[i]] <- c(exist_list[[i]], is.null(temp1))
      # ori_list <- c(ori_list,!is.null(temp1))
      lab_list <- c(lab_list,!is.null(temp4))
    }
  )
}
print(err)
lab_list <- as.numeric(lab_list)

#---------------------------------------------------------------
#---------------------------------------------------------------
#---------------------------------------------------------------

# check if distr (hist) of coefficients of small regressions are normal/ smooth
coeff_ori <- c()
coeff_cat3 <- c()
coeff_cat35 <- c()
coeff_lab <- c()
err <- c()
warn <- c()
for (i in 1:length(coef_list)){
  obj <- tryCatch(
    # {coeff_ori <- c(coeff_ori, coef_list[[i]]["X_truntrend_ori",1])
    # coeff_cat3 <- c(coeff_cat3, coef_list[[i]]["X_truntrend_cat3",1])
    # coeff_cat35 <- c(coeff_cat35, coef_list[[i]]["X_truntrend_cat35",1])
    # coeff_lab <- c(coeff_lab, coef_list[[i]]["X_truntrend_lab",1])},
    {coeff_ori <- c(coeff_ori, coef_list[[i]][2])
    coeff_cat3 <- c(coeff_cat3, coef_list[[i]][3])
    coeff_cat35 <- c(coeff_cat35, coef_list[[i]][4])
    coeff_lab <- c(coeff_lab, coef_list[[i]][5])},
    error = function(e) {err <<- c(err,e$message)},
    warnings = function(w) {warn <<- c(warn,w$message)}
  )
}
print(err)

hist(coeff_ori,breaks = 50)
hist(coeff_cat3,breaks = 50)
hist(coeff_cat35,breaks = 50)
hist(coeff_lab,breaks = 50)

summary(coeff_ori)
summary(coeff_cat3)
summary(coeff_cat35)
summary(coeff_lab)                                                                     # see the NAs from here

sum(lab_list)                       # not equal to coeff_lab, why ??
sum(cat3_list)
sum(cat35_list)
sum(ori_list)

sum(coeff_ori>1)                    # check size of coeffs
sum(coeff_cat3>1)
sum(coeff_cat35>1,na.rm = TRUE)
sum(coeff_lab>1, na.rm = TRUE)

coeff_cat35[is.na(coeff_cat35)==1] <- 0                                               
coeff_lab[is.na(coeff_lab)==1] <- 0
summary(coeff_cat35)
summary(coeff_lab)   

# get estimated coefficients of non-zero bands from coef_list
coeff_mat <- matrix(0,length(coef_list),5)
for (j in 1:length(coef_list)){
  if(ori_list[j]!=0){
    temp_1 <- coef_list[[j]][2]
  } else {
    temp_1 <- 0
  }
  if(cat3_list[j]!=0){
    temp_2 <- coef_list[[j]][3]
  } else {
    temp_2 <- 0
  }
  if(cat35_list[j]!=0){
    temp_3 <- coef_list[[j]][4]
  } else {
    temp_3 <- 0
  }
  if(lab_list[j]!=0){
    temp_4 <- coef_list[[j]][5]
  } else {
    temp_4 <- 0
  }
  temp_0 <- coef_list[[j]][1]
  coeff_mat[j,] <- c(temp_0, temp_1, temp_2, temp_3, temp_4)
}
max(coeff_mat, na.rm = TRUE)
min(coeff_mat, na.rm = TRUE)

#  create the full coefficient matrix for all 2588 bands                        
coeff_mat_full <- matrix(0,4061,5)                                           # w: change here ! 2017 Sep 27
k <- 1
for (i in 1:4061){                                                           # w: change here ! 2017 Sep 27
  if (band_name[i]%in%all_zeros_band_names){}
  else {
    coeff_mat_full[i,] <- coeff_mat[k,]
    k = k+1
  }
}
max(coeff_mat_full)
min(coeff_mat_full)

sum(is.na(coeff_mat_full))
# 0 values in coeff_mat_full belong to the bands with no value in all 4 trends
coeff_mat_full[is.na(coeff_mat_full)] <- 0                                          # get rid of NAs from here 
sum(is.na(coeff_mat_full))

# got rid of all_zeros_band_names at this chance?

######################################################################################
################## predict with estimated coefficients of 4 trends ###################
######################################################################################

from_ind = 1                                                                      
past_ind = 1
k = 1
log_y_hat <- c()

for (i in 2:nrow(adopt_trend_full)){
  if (adopt_trend_full[past_ind,6] != adopt_trend_full[i,6]){
    X <- as.matrix(adopt_trend_full[from_ind:(i-1),2:5])
    if (sum(X)!=0){
      X <- cbind(1,X)
      log_y_hat <- c(log_y_hat, log(X+1)%*%coeff_mat_full[k,])
      # log_y_hat <- c(log_y_hat, X%*%coeff_mat_full[k,])
    } else {
      log_y_hat <- c(log_y_hat, rep(NA,nrow(X)))                  # if band has no trend data (0s in all 4 trends) ~ 
    }                                                             # ~ set log_y_hat to NA
    from_ind = i
    k = k+1
    # print(from_ind)
  } else{}
  past_ind = i
}
X <- as.matrix(adopt_trend_full[from_ind:i,2:5])                  # add last band
X <- cbind(1,X)
log_y_hat <- c(log_y_hat, log(X+1)%*%coeff_mat_full[k,])
# log_y_hat <- c(log_y_hat, X%*%coeff_mat_full[k,])


y_hat <- exp(log_y_hat-1)                     # biased; need to transform back? See AMM L1 Slide 37

max(y_hat)                                    # exists some very large predicted values, use tobit instead ?
min(y_hat)
hist(y_hat[y_hat<100])
hist(y_hat[y_hat<20])

min(y_hat, na.rm = TRUE)
max(y_hat, na.rm = TRUE)
# sth <- na.omit(y_hat)

sum(y_hat > 100, na.rm = TRUE)
sum(y_hat > 1000, na.rm = TRUE)

summary(y_hat)

which.max(y_hat)                          # check why max predicted y_hat value is so big
adopt_trend_full[which.max(y_hat),]
X_max <- adopt_trend_full[which.max(y_hat),2:5]
X_max <- c(1,X_max)
X_max <- as.numeric(X_max)
which(band_name==4369)                    # seen from adopt_trend_full[which.max(y_hat),]
b_max <- coeff_mat_full[1864,]            # seen from which(band_name==4369)
result <- X_max%*%b_max
result
exp(result-1)

sum(is.na(y_hat))                       
sum(y_hat==0,na.rm = TRUE)
y_hat[is.na(y_hat)] <- 0                  # set the NAs of bands with no trend data to 0
sum(is.na(y_hat))
sum(y_hat==0)

sum(is.na(log_y_hat))                       
sum(log_y_hat==0,na.rm = TRUE)
log_y_hat[is.na(log_y_hat)] <- 0                  # set the NAs of bands with no trend data to 0
sum(is.na(log_y_hat))
sum(log_y_hat==0)

summary(log_y_hat)

predict_trend <- cbind(adopt_trend_full$bands_num_vec,adopt_trend_full$weeks_vec,y_hat)
predict_trend_log <- cbind(adopt_trend_full$bands_num_vec,adopt_trend_full$weeks_vec,log_y_hat)

write.csv(file="predict_trend4061.csv", x=predict_trend, row.names = FALSE)
write.csv(file="predict_trend_log4061.csv", x=predict_trend_log, row.names = FALSE)

########################################################
########################################################
########################################################

library(vars)
? VARselect