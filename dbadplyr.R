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



###------------------------ wasted ---------------------------
heavyyear10 <- tbl(db,sql("SELECT NAME, count(COUNTmod)
FROM (select *
from dtgenre
where WEEK_ID in (select week_ID from weeky where Yearw = 10))
GROUP BY NAME
           "))

expertYear10 <- collect(heavyyear10)

quantile(unlist(expertYear10[,2]), 0.8)
yindex10 <- which((expertYear10[,2])>450)
y10 <- expertYear10[yindex10,]

y1 <- cbind(y1,matrix(1,nrow(y1),1))
y2 <- cbind(y2,matrix(1,nrow(y2),1)*2)
y3 <- cbind(y3,matrix(1,nrow(y3),1)*3)
y4 <- cbind(y4,matrix(1,nrow(y4),1)*4)
y5 <- cbind(y5,matrix(1,nrow(y5),1)*5)
y6 <- cbind(y6,matrix(1,nrow(y6),1)*6)
y7 <- cbind(y7,matrix(1,nrow(y7),1)*7)
y8 <- cbind(y8,matrix(1,nrow(y8),1)*8)
y9 <- cbind(y9,matrix(1,nrow(y9),1)*9)
y10 <- cbind(y10,matrix(1,nrow(y10),1)*10)


expertUsers <- rbind(y1, y2, y3, y4, y5, y6, y7, y8, y9, y10)
write.csv(file="expertYear1.csv", x=expertYear1)
write.csv(file="expertUsers.csv", x=expertUsers)
###-----------------------------------------------------------------



Expertsum10 <- tbl(db,sql("SELECT WEEK_ID, GENRE, sum(COUNTmod), sum(PREV1), sum(PREV2), sum(PREV3), sum(PREV4), sum(PREV8), sum(PREV12), sum(PREV16), sum(PREV26), sum(PREV39), sum(PREV52)
FROM (select *
from dtgenre
where NAME in (SELECT NAME FROM expertUser WHERE YEAR = 10) and WEEK_ID in (SELECT WEEK_ID FROM weeky WHERE Yearw = 10))
GROUP BY GENRE, WEEK_ID
order by WEEK_ID
           "))

Expertyear10 <- collect(Expertsum10)

expertLis <- rbind(Expertyear1, Expertyear2, Expertyear3, Expertyear4, Expertyear5,
                   Expertyear6, Expertyear7, Expertyear8, Expertyear9, Expertyear10)

write.csv(file="expertLis.csv", x=expertLis)

#--------------------------------------------------------------------------
involveweek <- tbl(db,sql("SELECT dtgenre.NAME, GENRE, dtgenre.WEEK_ID, COUNTmod, invol, PREV1, PREV2, PREV3, PREV4, PREV8, PREV12, PREV16, PREV26, PREV52
FROM (select NAME, WEEK_ID, sum(COUNTmod) as invol
from dtgenre
group by NAME, WEEK_ID) as T, dtgenre
WHERE dtgenre.NAME = T.NAME and dtgenre.WEEK_ID = T.WEEK_ID
           "))

involvement <- collect(involveweek)

write.csv(file="involvement.csv", x=involvement)

#---------------------------------------------------------------------------

reexpertlis <- tbl(db,sql("select NAME, AGE, JOINmod, ndtgenre.GENRE, ndtgenre.WEEK_ID, EXPERTcount, ePREV1, ePREV2, ePREV3, ePREV4, ePREV8, ePREV12, ePREV16, ePREV26, ePREV39, ePREV52, MEMBER, PREV_1, PREV_2,PREV_3,PREV_4,PREV_8,PREV_12,PREV_16,PREV_26,PREV_39,PREV_52, FRIENDS, fPREV_1, fPREV_2,fPREV_3,fPREV_4,fPREV_8,fPREV_12,fPREV_16,fPREV_26,fPREV_39,fPREV_52, NEIGHBORS, nPREV_1, nPREV_2,nPREV_3,nPREV_4,nPREV_8,nPREV_12,nPREV_16,nPREV_26,nPREV_39,nPREV_52
from ndtgenre left outer join expertlis using (GENRE, WEEK_ID)
           "))

nexpertlis <- collect(reexpertlis)

write.csv(file="newexpertlis.csv", x=nexpertlis)


#-----------------------------------------------------------------------------
newinvolveweek <- tbl(db,sql("SELECT ndtartist.NAME, AGE, JOINmod, ARTIST, ndtartist.WEEK_ID, MEMBER, invol, PREV_1, PREV_2,PREV_3,PREV_4,PREV_8,PREV_12,PREV_16,PREV_26,PREV_39,PREV_52, FRIENDS, fPREV_1, fPREV_2,fPREV_3,fPREV_4,fPREV_8,fPREV_12,fPREV_16,fPREV_26,fPREV_39,fPREV_52, NEIGHBORS, nPREV_1, nPREV_2,nPREV_3,nPREV_4,nPREV_8,nPREV_12,nPREV_16,nPREV_26,nPREV_39,nPREV_52
FROM (select NAME, WEEK_ID, sum(MEMBER) as invol
from ndtartist
group by NAME, WEEK_ID) as T, ndtartist
WHERE ndtartist.NAME = T.NAME and ndtartist.WEEK_ID = T.WEEK_ID
                          "))

newinvolvement <- collect(newinvolveweek)

write.csv(file="newinvolvement.csv", x=newinvolvement)


