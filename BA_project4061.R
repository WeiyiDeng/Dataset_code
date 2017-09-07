# w: DO NOT run this, not work anymore !!!!

setwd("E:/Trans/Transfer from old Toshiba/SQLite")

# install.packages("dbplyr")
library("dbplyr")
library("dplyr")
library("ggplot2")
library("RSQLite")

db <- src_sqlite("dbaf.db")          # link with database db_mod
db_tba1 <- tbl(db, "newbandlist")          # link with table dataset1
db_tba2 <- tbl(db, "small_bands_names4061")          # link with table dataset1


# select random bands from the 6046 bands
x <- 1:6046
set.seed(401716)
rand_sample_bands <- sample(x,20)

take_bandlist <- tbl(db,sql("select * from newbandlist"))
bandlist <- collect(take_bandlist)

sample_bands <- bandlist[rand_sample_bands,]

# select random bands from the 2588 bands
x <- 1:4061
set.seed(401716)
rand_sample_bands <- sample(x,20)

take_small_bandlist <- tbl(db,sql("select * from small_bands_names4061"))
small_bandlist <- collect(take_small_bandlist)

sample_bands2 <- small_bandlist [rand_sample_bands,]

# write.csv(file="sample_bands_50.csv", x=sample_bands2[,2])

# save all 2588 bands to csv
write.csv(file="newbandlist4061.csv", x=small_bandlist[,2], fileEncoding = "UTF-8")        # w: DOES NOT work: VM cannot open the exported file anymore !!!!
# NOTICE if some characters are not encoded correctly, use cmd sql to export newbandlist4061.csv directly from dataset

# 20 sample_bands from 6046 bands with random seed set to 401716
# no artist term
# https://www.google.com/trends/explore?q=M%C3%83%C2%A9lanie%20Pain
# not enough data
# https://www.google.com/trends/explore?q=Last%20Days
# rock band
# https://www.google.com/trends/explore?q=%2Fm%2F03f3ty7
# not enough data
# https://www.google.com/trends/explore?q=Jim%20James%20%26%20Calexico
# rock band
# https://www.google.com/trends/explore?q=%2Fm%2F03xpkvp
# not enough data
# https://www.google.com/trends/explore?q=Jazzy%20Pecada
# actor
# https://www.google.com/trends/explore?q=%2Fm%2F016xh5
# musical group
# https://www.google.com/trends/explore?q=%2Fm%2F03f76sr
# musical group
# https://www.google.com/trends/explore?q=%2Fm%2F01vz25w
# music performer
# https://www.google.com/trends/explore?q=%2Fm%2F0134tzs_
# no artisit term
# https://www.google.com/trends/explore?q=Now,%20Now%20Every%20Children
# rock band
# https://www.google.com/trends/explore?q=%2Fm%2F0h24427
# band
# https://www.google.com/trends/explore?q=%2Fm%2F049gp1z
# rock band
# https://www.google.com/trends/explore?q=%2Fm%2F03c3h4s
# musical duo
# https://www.google.com/trends/explore?q=%2Fm%2F0q4zxwv
# rock band
# https://www.google.com/trends/explore?q=%2Fm%2F012ngh5c
# music producer
# https://www.google.com/trends/explore?q=%2Fm%2F03j3h7q
# no artist term
# https://www.google.com/trends/explore?q=Xaphoon%20Jones
# not enough data
# https://www.google.com/trends/explore?q=Jos%C3%83%C2%A9%20James
# rock band
# https://www.google.com/trends/explore?q=%2Fm%2F01tx4dj

###
# 20 sample_bands from 2588 bands with random seed set to 401716
# rock band
# https://www.google.com/trends/explore?q=%2Fm%2F0dpsfd9
# musical group
# https://www.google.com/trends/explore?q=%2Fm%2F0x4fc42
# musical group
# https://www.google.com/trends/explore?q=%2Fm%2F01mlb3c
# search term (suggested search 'Eden xo' singer-songwriter; possibly confusing album name with artist name)
# https://www.google.com/trends/explore?q=Jessie%20And%20The%20Toy%20Boys
# rock band
# https://www.google.com/trends/explore?q=%2Fm%2F0dmv1vn
# hip-hop artist
# https://www.google.com/trends/explore?q=%2Fm%2F01w2ksr
# search term (no artist term)
# https://www.google.com/trends/explore?q=Hugo
# musical artist
# https://www.google.com/trends/explore?q=%2Fm%2F0qjjhqb
# singer
# https://www.google.com/trends/explore?q=%2Fm%2F01tz943
# musical artist
# https://www.google.com/trends/explore?q=%2Fm%2F0nhtbl4
# search term (no artist term)
# https://www.google.com/trends/explore?q=no
# rock band
# https://www.google.com/trends/explore?q=%2Fm%2F0h7qhs6
# composer
# https://www.google.com/trends/explore?q=%2Fm%2F01pz6ng
# musical artist
# https://www.google.com/trends/explore?q=%2Fm%2F0vpy3l3
# search term (no suggetsed terms)
# https://www.google.com/trends/explore?q=Pale%20Seas
# musical group
# https://www.google.com/trends/explore?q=%2Fm%2F0vxzy8l
# search term (suggested term studio album by Bob Seger & The Silver Bullet Band; possibly confusing album name with artist name)
# https://www.google.com/trends/explore?q=Night%20Moves
# band
# https://www.google.com/trends/explore?q=%2Fm%2F0ch19p0
# singer-songwriter
# https://www.google.com/trends/explore?q=%2Fm%2F09k2t1
# musical artist
# https://www.google.com/trends/explore?q=%2Fm%2F0frv33x


### try using gtrendsR (cannot get lables, later switched to pytrends API in python)
# https://www.google.com/trends/explore?cat=35&date=2004-01-01%202016-11-01&q=Sparzanza
install.packages("gtrendsR")
library(gtrendsR)
?? gtrendsR

# try example
usr <- ""  # alternatively store as options() or env.var
psw <- ""        # idem
gconnect(usr, psw) 
# session <- gconnect("usr@gmail.com", "psw")
sport_trend <- gtrends(c("nhl", "nba", "nfl"))                  # compare trends of keywords "nbl", "nba", "nfl"
plot(sport_trend)
view_trend <- sport_trend$trend                                 # retreive trends from the list of results
head(view_trend)


##
# trySparzanza <- gtrends("Sparzanza", cat="0-3-35", start_date= "2011-11-06", end_date = "2016-10-30")
trySparzanza <- gtrends("Sparzanza", cat="35", start_date= "2011-11-06", end_date = "2016-10-30")
# trySparzanza <- gtrends("Sparzanza", start_date= "2011-11-06", end_date = "2016-10-30")
# trySparzanza <- gtrends("jaguar", cat="66", start_date= "2011-11-06", end_date = "2016-10-30")
# trySparzanza <- gtrends("jaguar", cat="12", start_date= "2011-11-06", end_date = "2016-10-30")
plot(trySparzanza)
get_trend <- trySparzanza$trend


tryQueen <- gtrends("Queen", cat="35", start_date= "2011-11-06", end_date = "2016-10-30")
plot(tryQueen)
get_trend <- tryQueen$trend
# compare
# https://www.google.com/trends/explore?q=%2Fm%2F0bk1p
# https://www.google.com/trends/explore?cat=35&q=queen
# https://www.google.com/trends/explore?q=queen


### try interplolation with spline (cubic/polynomial lines)
trydata <- read.csv(file="E:/Trans/Transfer from old Toshiba/TransferSpot/bands4061_ori/5_ori.csv", header=TRUE, sep=",")
class(trydata)
month_trend <- trydata[,2]
plot(month_trend, type="o")
length(month_trend)

trun_month <- month_trend[8:143]                # from Sunday, 1 August 2004 to Sunday, 1 November 2015
plot(trun_month[85:length(trun_month)], type="o")
# length(8:143)                                 # length of trun_month is 136

? splinefun
n <- 588                           # 587 weeks between Sunday, 1 August 2004 and Sunday, 1 November 2015
week_trend <- spline(1:length(trun_month), trun_month, n)
week_trend$y
plot(week_trend$y)
plot(week_trend$y[350:588], type="o")

# 28 weeks between Sunday, 1 August 2004 and Sunday, 13 February 2005
# 33 weeks between Sunday, 15 March 2015 and Sunday, 1 November 2015
week_gtrend <- week_trend$y[29:555]
week_gtrend
