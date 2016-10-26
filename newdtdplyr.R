library("dplyr")
library("ggplot2")
? dplyr

library("RSQLite")

db <- src_sqlite("dtnew-w.db")          # link with database db_mod
db_tbn1 <- tbl(db, "newtable1")          # link with table dataset1
db_tbn2 <- tbl(db, "newtable2")
db_tbn3 <- tbl(db, "newtable3")
db_tbn4 <- tbl(db, "newtable4")
db_tbn5 <- tbl(db, "newtable5")
db_tbn6 <- tbl(db, "newtable6")
db_tbn7 <- tbl(db, "newtable7")

# to clean dataset4, check IS NULL and not number (NOT LIKE & GLOB) for duration

# ---------------testing duration--------------
checkt1 <- tbl(db,sql("select DURATION
from newtable4
where DURATION < 7200000
           "))

check_duration <- collect(checkt1)


numeric_duration <- as.numeric(check_duration$DURATION)
logDuration <- log(numeric_duration+2)
hist(logDuration)

#unchanged <- as.numeric(check_duration$DURATION)
#hist(log(unchanged+2))
#hist(log(unchanged+2))
#unchange2 <- c()
#for (i in 1:length(unchanged)){
#  if (unchanged[i]<10000000){unchange2[i]=unchanged[i]}
#  else{unchange2[i]=401716}
#}
#hist(unchanged2)

options(scipen=999)                  ###### disabled scientific notation ! To change back, set options(scipen=0)

summary(numeric_duration) 

checkt1_3 <- tbl(db,sql("select DURATION
           from newtable4
           where DURATION < 10000000
           "))
check_duration3 <- collect(checkt1_3)
summary(check_duration3)
hist(as.numeric(check_duration3$DURATION), breaks=30)

# correlation between count and count*duration
checkt12 <- tbl(db,sql("select table7date.TRACK_ID, COUNT_mod, COUNT_mod*DURATION as multip
from newtable4, table7date
where table7date.TRACK_ID = newtable4.TRACK_ID and DURATION < 7200000 and COUNT_mod < 100 and DURATION > 0
           "))

check_duration12 <- collect(checkt12)

table(check_duration12[,2])

barplot(table(check_duration12[,2]))

hist(as.numeric(unlist(check_duration12[,3])), breaks=1000)

r <- cor(check_duration12[,2], check_duration12[,3])

write.csv(file="correlation_check.csv", x=check_duration12)

#
checkt10 <- tbl(db,sql("select COUNT_mod
from table7date
where COUNT_mod < 200
           "))

check_duration10 <- collect(checkt10)

table(check_duration10)
barplot(table(check_duration10))

#-----------------check num of friends & neighbours---------------------

userf <- tbl(db,sql("select USER, count(distinct FRIEND)
           from newtable2
           Group by USER 
           "))
user_friend <- collect(userf)

table(user_friend$count)
barplot(table(user_friend$count), main = "Histogram of number of friends of each USER", 
        xlab = "number of friends", ylab ="USER count")

summary(user_friend$count)

# random checks on the website suggest the num of friends are correct !
# user "skeleandmole" has over 10000 friends, which are half of the observations in dataset2
# Checking on the website suggests this "person" really has that much friends...

# to find the user with max friends:
# SELECT USER, max(num)
# FROM (select USER, count(distinct FRIEND) as num
# from newtable2
# Group by USER) as try
# to find the user with 2nd largest number of friends:
# WHERE USER != "skeleandmole"

userNeighb <- tbl(db,sql("select USER, count(distinct NEIGHBOUR)
           from newtable3
           Group by USER 
           "))
user_neighb <- collect(userNeighb)

table(user_neighb$count)
barplot(table(user_neighb$count), main = "Histogram of number of neighbours each USER has", 
        xlab = "number of neighbours", ylab ="USER count")

summary(user_friend$count)

# a small group of users have less than 50 neighbours in the data for unknown reasons...on the website it shows 50
# user "TheMadHacker" has less than 50 neighours on the actual website for unknown reasons...

# or to find users with num of neigbours < 50:
# select USER, num
# from (select USER, count(distinct NEIGHBOUR) as num 
#      from newtable3
#      Group by USER) as sub
# where num < 50

# random checks on the website suggest that tags are correct
# API gets 20 tags for each track
# to check if there are more tags:
# SELECT count(*)
# from newtable5
# where tag21 is not null or num21 is not null


#---------------------check months-------------------------------

year_month <- tbl(db,sql("select strftime('%Y-%m', date_mod)
      from table7date 
           "))

yearmonth <- collect(year_month)

table(yearmonth)

barplot(table(yearmonth), main="month distribution of observations",
        xlab = "month", ylab ="observations count")

#--------------------check total listens per user-----------------

userLis <- tbl(db,sql("select USER_mod, sum(COUNT_mod)
      from table7date
      group by USER_mod
           "))
user_lis <- collect(userLis)

unlistedLis <- as.numeric(unlist(user_lis[,2]))
hist(unlistedLis, breaks = 100, main = "total number of listens")

summary(user_lis)

#-----------------check users presence across time-----------------

## the number of users present in each month
monthp <- tbl(db,sql("SELECT tdate, count(distinct USER_mod)
      FROM (select USER_mod, strftime('%Y-%m', date_mod) as tdate
            from table7date) as tMonth
      GROUP BY tdate
           "))

present_month <- collect(monthp)
View(present_month)

countmonth = present_month[,2]
namemonth = present_month[,1]

plot(unlist(countmonth), type = "h", xaxt = "n", xlab = "month number", ylab = "number of users",
     main = "the number of users present in each month")
axis(1, at=1:nrow(present_month), labels=unlist(namemonth))

# the number of active months of users
userp <- tbl(db,sql("SELECT USER_mod, count(distinct tdate)
          FROM (select USER_mod, strftime('%Y-%m', date_mod) as tdate
               from table7date) as tMonth
          GROUP BY USER_mod
                    "))

present_user <- collect(userp)
table(present_user$count)

hist(present_user$count, breaks=25, xlab = "number of months present", ylab = "count users",
     main = "the number of active months of users 
     (e.g. some are active for 1, 2, 3... weeks)")

#----------------------------------------------------
#------------------check over------------------------
#----------------------------------------------------
