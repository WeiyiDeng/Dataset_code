# setwd("D:/Program Files/SQLite")

library("dplyr")
library("ggplot2")
? dplyr

library("RSQLite")

db <- src_sqlite("dbr.db")          # link with database db_mod
db2 <- src_sqlite("dbas.db")          # link with database db_mod
db_tba1 <- tbl(db, "adoptobs")          # link with table dataset1
db_tba2 <- tbl(db2, "modelbandweeks")

## can use paste to perform iterative queries
# mytry <- paste("select BAND_ID, WEEK, count(*) from adoptobs", "group by BAND_ID, WEEK", sep = " ")
# mytry
# adoptweeks <- tbl(db,sql(mytry))

adoptweeks <- tbl(db,sql("select BAND_ID, WEEK, count(*)
from adoptobs
group by BAND_ID, WEEK"))

# check to see the percentage of weeks that have sufficient data
ad_weeks <- collect(adoptweeks)
barplot(table(ad_weeks[,3]), xlab = "num of adoptions", ylab = "num of weeks")

# A <- table(ad_weeks[,3])
# sum(A)

# check how many weeks are within weeks of more adoptions
freq_table <- data.frame(table(ad_weeks[,3]))
freq_table <- as.matrix(freq_table)
ftry <- as.numeric(freq_table)
f_table <- matrix(ftry, ncol=2, byrow=FALSE)
total_adoptions <- f_table[,1]*f_table[,2]
total_adoptions
barplot(total_adoptions, xlab = "total num of adoptions in the same week", 
        ylab = "total num of adoptions (# of adoptions * # of weeks)")



##########################################################
############## Do not implement this part ################
##########################################################

# get the num of listens per user per band per week
listens <- tbl(db2,sql("select COUNTmod
from modelbandweeks"))

lis_weeks <- collect(listens)
# hist(lis_weeks$COUNTmod, breaks=30)

loglisweeks <- log(lis_weeks)         # w: plus one or not??

hist(loglisweeks$COUNTmod)

# loglisweeks <- loglisweeks$COUNTmod
# std_loglisweeks <- (loglisweeks - mean(loglisweeks))/sd(loglisweeks)     std?

rm(lis_weeks)             # to save memory
# write.csv(file="loglisweeks.csv", x=loglisweeks)             # too many decimals

try6digs <- round(loglisweeks, digits = 6)
rm(loglisweeks)
write.csv(file="loglisweeks.csv", x=try6digs)
#########################################################
#########################################################
#########################################################


## log listen vs adopt per band per week
loglis_adopt <- tbl(db,sql("select listen, adopt
from loglistens"))

loglis_adopts <- collect(loglis_adopt)

cor(loglis_adopts$listen, loglis_adopts$adopt)
with(loglis_adopts, plot(listen, adopt, col=2, xlab = "log listen"))

# after std
logl <- loglis_adopts$listen
std_loglisten <- (logl - mean(logl))/sd(logl)
cor(std_loglisten, loglis_adopts$adopt)
plot(std_loglisten, loglis_adopts$adopt, col=2, xlab = "log listen std")



## ind listen vs adopt per band per week
indlis_adopt <- tbl(db,sql("select listen, adopt
from indlistens"))

indlis_adopts <- collect(indlis_adopt)

cor(indlis_adopts$listen, indlis_adopts$adopt)
with(indlis_adopts, plot(listen, adopt, col = "blue", xlab = "ind listen"))



## total listen vs adopt per band per week (small)
totalis_adopt <- tbl(db,sql("select listen, adopt
from totallistens"))

totalis_adopts <- collect(totalis_adopt)

cor(totalis_adopts$listen, totalis_adopts$adopt)
with(totalis_adopts, plot(listen, adopt, col = "blue", xlab = "total listen"))



## total listen vs adopt per band per week (big)
totalis_adopt2 <- tbl(db,sql("select listen, adopt
from totallistenb"))

totalis_adoptb <- collect(totalis_adopt2)

cor(totalis_adoptb$listen, totalis_adoptb$adopt)
with(totalis_adoptb, plot(listen, adopt, col = "blue", xlab = "total listen"))


## try with trends data (ind listens vs trends)
Ed_Sheeran <- tbl(db,sql("select WEEK_ID, listen, adopt, trend, week
from EdSindlis, trendtb1
where EdSindlis.WEEK_ID = trendtb1.week"))

try_trend <- collect(Ed_Sheeran)

cor(try_trend$trend, try_trend$adopt)
with(try_trend, plot(trend, adopt, col = "blue"))

# checking
cor(try_trend$trend, try_trend$listen)        # high corr between trend and num listeners though

# checking
# sum(try_trend$adopt)         # in total 291 out of 6000+ users adopted the artist

## try substract listens from previous week
pre_indlis <- tbl(db,sql("select * from indlistens"))
sub_indlis <- collect(pre_indlis)

# checking
D <- 0
for (i in 1:100){
  D = D+i
}
# check over

bandid <- sub_indlis$BAND_ID
lis <- sub_indlis$listen

sub_prev <- c()
sub_prev[1] <- lis[1]
for (i in 2:nrow(sub_indlis)){
  if (bandid[i]==bandid[i-1]){
    sub_prev[i] = lis[i]-lis[i-1]
  }
  else {sub_prev[i] = lis[i]}
}
cor(sub_prev,sub_indlis$adopt)


## try lag indlis

# a <- seq(1,10)
# a <- a[-1]             # remove 1st obs

pre_indlis_lag <- tbl(db,sql("select *
from indlistens
where BAND_ID in (SELECT BAND_ID
FROM (select BAND_ID, count(*) as numweeks
from indlistens
group by BAND_ID)
WHERE numweeks > 1)"))

pre_lag <- collect(pre_indlis_lag)

bandid <- pre_lag$BAND_ID
lis <- pre_lag$listen
ado <- pre_lag$adopt

# count num rows of each band!
k <- 1
laglis <- c()
laglis[1] <- lis[k+1]
for (i in 2:nrow(pre_lag)){
  if (bandid[i]==bandid[i-1]){
    laglis[i] = laglis[i-1]
  }
  else {sub_prev[i] = lis[i]}
}
cor(sub_prev,sub_indlis$adopt)
# to be completed--------------


## prepare band and weeks for google trends
db3 <- src_sqlite("dbaf.db")
db_tba5 <- tbl(db3, "newbandlist")

prep_bandweeks <- tbl(db,sql("
SELECT adoptbandweeks.BAND_ID, ARTIST, adoptbandweeks.week_ID, date(FROM_UTS, 'unixepoch') as startdate, FROM_UTS
FROM adoptbandweeks, dbaf.newbandlist, weeky
WHERE adoptbandweeks.BAND_ID = dbaf.newbandlist.BAND_ID and adoptbandweeks.week_ID = weeky.week_ID
"))

pre_bandweeks <- collect(prep_bandweeks)
