library("dplyr")
library("ggplot2")
? dplyr

library("RSQLite")

db <- src_sqlite("funds.db")
db_ff <- tbl(db, "fundf")           # w: ??
db_mp <- tbl(db, "matchp")          # w: ??

# remove empty record from the last line in sql GUI
#
bklist <- tbl(db,sql("select distinct Bank
from matchp
                     "))

banklist <- collect(bklist)

write.csv(file="banklist.csv", x=banklist)

#
fflist <- tbl(db,sql("select distinct FundFirm
from matchp
                     "))

fundflist <- collect(fflist)

write.csv(file="fundflist.csv", x=fundflist)