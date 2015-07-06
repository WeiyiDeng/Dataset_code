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
where FROM_UTS in (select FROM_UTS from weeky where Yearw = 1))
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

write.csv(file="bandadoption.csv", x=adoptijt)
write.table(adoptijt, "bandadoptions.csv", row.names=F, col.names=F, sep=",")
# use write.table to create csv file without column and row names 
