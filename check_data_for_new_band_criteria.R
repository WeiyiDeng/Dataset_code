setwd("E:/Trans/Transfer from old Toshiba/SQLite")

library(ggplot2)

start_date <- 20050213
mydate <- as.Date(as.character(start_date), "%Y%m%d")
mydate_time <- paste(mydate, "13:00:00 UTC", sep = "")
as.numeric(as.POSIXct(mydate_time))

# min(FROM_UTS) 1108296002
# max(FROM_UTS) 1426420800

end_date <- 20150315
mydate <- as.Date(as.character(end_date), "%Y%m%d")
mydate_time <- paste(mydate, "13:00:00 UTC", sep = "")
as.numeric(as.POSIXct(mydate_time))

w <- 20050213
prep_date <- c(w)
for (i in 1:121){
  w = w+100
  if (as.numeric(substr(toString(w), 5, 6))>12){
    w <- w+10000-1200
  }
  print(w)
  prep_date <- c(prep_date,w)
}

cutbands_min_UTS <- read.csv("cutbands_min_UTS.csv",header = TRUE)
count_bands_num_user <- read.csv("count_bands_num_user.csv",header = TRUE)

count_new_bands_months <- c()
for (i in 1:122){
  start_date <- prep_date[i]
  mydate <- as.Date(as.character(start_date), "%Y%m%d")
  mydate_time <- paste(mydate, "13:00:00 UTC", sep = "")
  UTS_month <- as.numeric(as.POSIXct(mydate_time))
  count_new_bands_months <- c(count_new_bands_months,sum(cutbands_min_UTS$min_UTS>UTS_month))
  print(count_new_bands_months)
}

quantile(count_bands_num_user$num_user,seq(0,1,0.025))
mydtframe <- as.data.frame(count_bands_num_user$num_user[count_bands_num_user$num_user<168])
colnames(mydtframe) <- c("NUM_USER")
ggplot(mydtframe, aes(x=NUM_USER)) + geom_histogram(binwidth=3) + geom_density(aes(y=1.3*..count..)) 

mydtframe2 <- as.data.frame(cbind(c(1:122),count_new_bands_months))
colnames(mydtframe2) <- c("num_months","count_new_bands_months")
ggplot(mydtframe2,aes(x=num_months)) + geom_point(aes(y=count_new_bands_months)) + geom_line(aes(y=count_new_bands_months))



