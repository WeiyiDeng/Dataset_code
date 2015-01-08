# check TRACK_DURATION 
checkt1 <- tbl(db,sql("select TRACK_DURATION
           from dataset1
           "))

check_duration <- collect(checkt1)

hist(check_duration$TRACK_DURATION, breaks=30)

summary(check_duration) 

options(scipen=999)                  ###### disabled scientific notation ! To change back, set options(scipen=0)

summary(check_duration)         #about 40000 observations have track_durations larger than 1000000, see sql check_track_duration

## try plot data with TRACK_DURATION above 10000000
checkt1_3 <- tbl(db,sql("select TRACK_DURATION
           from dataset1
           where TRACK_DURATION > 10000000
           "))
check_duration3 <- collect(checkt1_3)
summary(check_duration3)
hist(check_duration3$TRACK_DURATION, breaks=30)

## try plot skipping with TRACK_DURATION below 50000
skipp <- tbl(db,sql("select TRACK_DURATION
           from dataset1
           where TRACK_DURATION < 50000
           "))
skip <- collect(skipp)
summary(skip)
hist(skip$TRACK_DURATION, breaks=30)


# check ID_TRACK
checkt2 <- tbl(db,sql("select ID_TRACK
           from dataset1
           "))

check_trackid <- collect(checkt2)

hist(check_trackid$ID_TRACK, breaks=30)

#-------test--------

db_apply <- tbl(db, "Apply")

applys <- tbl(db,sql("select sID, count(distinct cName)
           from Apply
           Group by sID 
           "))

applytry2 <- collect(applys)

barplot(table(applytry2$count))

#---------------------
# check how many friends each individual user has
userf <- tbl(db,sql("select ID_USER, count(distinct ID_FRIEND)
           from dataset2
           Group by ID_USER 
           "))

user_friend <- collect(userf)

table(user_friend$count)
barplot(table(user_friend$count), main = "Histogram of number of friends of each USER_ID", 
        xlab = "number of friends", ylab ="USER_ID count")

summary(user_friend$count)

#-----------------------------------------------------
# plot number of band(artist) switches in weeks

db_tbtry1 <- tbl(db, "tb_type")
db_tbtry2 <- tbl(db, "Week2")

switchw <- tbl(db,sql(" select count(distinct ID_ARTIST)
           from (select *
           from tb_type, Week2
           Where tb_type.UTS = Week2.UTS and tb_type.ID_USER =Week2.ID_USER)
           Group by weekround, ID_USER
           "))
switchv <- collect(switchw)
table(switchv)
barplot(table(switchv), main = "number of band switches of each users each week (all weeks combined)",
        xlab = "number of switches", ylab ="number of users")
# 1 is no switch here, could due to only have one listen this week
#----------------------------------------------
