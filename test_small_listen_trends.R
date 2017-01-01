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

# store r squared outout from lm 
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
trydata <- read.csv(file="E:/Trans/Transfer from old Toshiba/SQLite/listen_trends_left_join.csv", header=TRUE, sep=",")
listen_trend <- trydata[,-2]                     # remove adopt data for now

r_square_vec <- c()
coef_list <- list()
less_row_band <- c()
all_zero_band <- c()
from_ind = 1
past_ind = 1
k <- 1
# for (i in 2:29){
for (i in 2:nrow(listen_trend)){
  if (listen_trend[past_ind,6] != listen_trend[i,6]){
    # print(from_ind)
    # print(i-1)
    if (i-from_ind<5){
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
    from_ind = i
    # print(from_ind)
  } else {}
  past_ind = i
  # print(past_ind)
}
# cor_list <- c(cor_list, cor(listen_trend[from_ind:nrow(listen_trend),3],listen_trend[from_ind:nrow(listen_trend),5]))
# add the last band to the vector

length(all_zero_band)
length(less_row_band)
mean(r_square_vec)

###
### g1+g2+g3+g4
###
gtrends_sum <- apply(listen_trend[,2:5],1,sum)

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
hist(cor_distr, breaks = 20)
sum(cor_distr==1)
# add the last band to the vector
