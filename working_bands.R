library("dplyr")
library("ggplot2")
? dplyr

library("RSQLite")

db <- src_sqlite("dba.db")          # link with database db_mod
db_tba1 <- tbl(db, "dt1")          # link with table dataset1
db_tba2 <- tbl(db, "dt2")
db_tba3 <- tbl(db, "dt3")
db_tba4 <- tbl(db, "dt4")
db_tba5 <- tbl(db, "dt5")
db_tba6 <- tbl(db, "dt6")
db_tba7 <- tbl(db, "dt7")
db_album <- tbl(db, "dtalbum")
db_artist <- tbl(db, "dtartist")
db_genre <- tbl(db, "dtgenre")
dbn_album <- tbl(db, "ndtalbum")
dbn_artist <- tbl(db, "ndtartist")
dbn_genre <- tbl(db, "ndtgenre")

listenBands <- tbl(db,sql("select USER, FROM_UTS, dt7.TRACK_ID, COUNTmod, ARTIST
from dt7, dt4
where dt7.TRACK_ID = dt4.TRACK_ID
           "))

bandlis <- collect(listenBands)

write.csv(file="bandlisten.csv", x=bandlis)

# delete duplicated column from bandlis in SQL GUI

newBands <- tbl(db,sql("SELECT *
FROM bandlis
WHERE ARTIST not in (select ARTIST
                       from bandlis
                       where FROM_UTS in (select FROM_UTS from weeky where Yearw = 1 or Yearw = 2)) and ARTIST not in (select ARTIST
                       from (SELECT ARTIST, count(distinct USER) as num_user
                       FROM (select USER, ARTIST
                       from bandlis
                       group by USER, ARTIST)
                       GROUP BY ARTIST)
                       where num_user <= 2)
           "))

bandnew <- collect(newBands)

write.csv(file="newbands.csv", x=bandnew)

#
newBandslis <- tbl(db,sql("SELECT USER, TRACK_ID, COUNTmod, ARTIST, week_ID, newbands.FROM_UTS
FROM newbands, weeky
where newbands.FROM_UTS = weeky.FROM_UTS
           "))

bandnewlis <- collect(newBandslis)

write.csv(file="newbandlis.csv", x=bandnewlis)

#
nblist <- tbl(db,sql("select distinct ARTIST
from newbandlis
order by ARTIST
           "))

newbandlist <- collect(nblist)

write.csv(file="newbandlist.csv", x=newbandlist)

#
userlist <- tbl(db,sql("select distinct USER
from newbandlis
order by USER
           "))

userslist <- collect(userlist)

write.csv(file="userlist.csv", x=userslist)

#
bandAdoption <- tbl(db,sql("SELECT Adopt.USER, Adopt.ARTIST, USER_ID, BAND_ID, week
FROM (select USER, ARTIST, min(week_ID) as week
from newbandlis
group by USER, ARTIST) as Adopt, newbandlist, userlist
WHERE Adopt.ARTIST = newbandlist.ARTIST and Adopt.USER = userlist.USER
ORDER BY USER_ID, BAND_ID
           "))

bandsadopt <- collect(bandAdoption)

adoptijt <- bandsadopt[,3:5]

# write.csv(file="bandadoption.csv", x=adoptijt)
write.table(adoptijt, "bandadoptions.csv", row.names=F, col.names=F, sep=",")
# use write.table to create csv file without column and row names 

#
splittime <- tbl(db,sql("select USER_ID, astart, midtime, aend
from (SELECT End.USER as NAME, astart, astart+(aend-astart)/2 as midtime, aend 
FROM (select USER, max(week_ID) as aend
                        from newbandlis
                        group by USER) as End, (select USER, min(week_ID) as astart
                        from newbandlis
                        group by USER) as Str
                        WHERE End.USER = STR.USER) as Mid, userlist
                        where userlist.USER = Mid.NAME
           "))

tsplit <- collect(splittime)

write.table(tsplit, "tsplit.csv", row.names=F, col.names=F, sep=",")

# band intro date
introdate <- tbl(db,sql("SELECT BAND_ID, introdate
FROM (select ARTIST, min(week_ID) as introdate
from newbandlis
group by ARTIST) as D, newbandlist
WHERE D.ARTIST = newbandlist.ARTIST
           "))

startdate <- collect(introdate)

write.table(startdate, "introdate.csv", row.names=F, col.names=F, sep=",")


# for computing EA score
adoptingweek <- tbl(db,sql("select USER_ID, mod_adoptions.BAND_ID, mod_adoptions.week_mod, introdate.week_mod as bandintro, peak.week_mod as bandpeak
from mod_adoptions, peak, introdate
where mod_adoptions.BAND_ID = peak.BAND_ID and mod_adoptions.BAND_ID = introdate.BAND_ID
           "))

adoptweek <- collect(adoptingweek)

write.table(adoptweek, "adoptingweek.csv", row.names=F, col.names=F, sep=",")


# 
EAs <- read.csv("EAi.csv",header = FALSE)

b <- quantile(EAs[,2], probs = seq(0, 1, 0.33))
# quantile(EAs[,2], probs = c(0, 0.16, 0.84, 1))         # alternatively
b <- quantile(EAs[,2], probs = c(0, 0.63, 0.84, 1))         # for now, otherwise breaks are not unique
V3 = cut(EAs[,2], breaks=b, include.lowest = TRUE, right = FALSE)  # include lowest and highest end values
summary(V3)
levels(V3) <- c("LA","MA","EA")
summary(V3)
EAs <- cbind(EAs, V3)

write.csv(file="EAcats.csv", x=EAs)
