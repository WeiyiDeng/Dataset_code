# plot YY-MM distribution converted from UTS
db_tbtime <- tbl(db, "Yearmon")

year_month <- tbl(db,sql("select *
           from Yearmon           
           "))

yearmonth <- collect(year_month)

table(yearmonth$month)

barplot(table(yearmonth$month), main="month distribution of observations",
        xlab = "month", ylab ="observations count")

# plot UTS distribution       # where GROUPnew == 1 and UTS > 0
uts1 <- tbl(db,sql("select UTS
           from dataset1
           "))

uts_t <- collect(uts1)

hist(uts_t$UTS, main = "UTS distribution")

## plot variance of number of listens per week
db_tbweek <- tbl(db, "Week")

weekr <- tbl(db,sql("select weekround
           from Week
           where UTS > 0
           "))

weeks <- collect(weekr)

table(weeks$weekround)
barplot(table(weeks$weekround), xlab = "week number", ylab = "number of listens",
        main = "variance of number of listens across weeks")

#----------------testing---------------------

db_apply <- tbl(db, "Apply")

applyc <- tbl(db,sql("select cName, count(distinct sID)
           from Apply
           Group by cName 
           "))

applytry <- collect(applyc)

cutcount = applytry[,2]
cutName = applytry[,1]
plot(unlist(cutcount), type = "h", xaxt = "n", xlab = "g")
axis(1, at=1:4, labels=unlist(cutName))
#----------------test over-----------------------

## plot variance of the number of users present in each week
weekp <- tbl(db,sql("select weekround, count(distinct ID_USER)
           from Week
           Group by weekround 
           "))

present_week <- collect(weekp)

# sum(present_week[,2])
countweek = present_week[,2]
nameweek = present_week[,1]

plot(unlist(countweek), type = "h", xaxt = "n", xlab = "week number", ylab = "number of users",
     main = "variance of the number of users presented across week")
axis(1, at=1:nrow(present_week), labels=unlist(nameweek))

#--------------------------------------------------------------
## plot variance in the number of active weeks across users
## Here an active week is defined if the user has any listens in the particular week 
userp <- tbl(db,sql("select ID_USER, count(distinct weekround)
           from Week
           Group by ID_USER 
           "))

present_user <- collect(userp)
table(present_user$count)

hist(present_user$count, breaks=25, xlab = "number of weeks present", ylab = "count users",
     main = "variance of the number of active weeks across users 
     (e.g. some are active for 1, 2, 3... weeks)")
