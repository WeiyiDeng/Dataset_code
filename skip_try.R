# data used was a subsample of first 10000 observations in dataset1
db_tbtry1 <- tbl(db, "tb_type")
db_tbsample <- tbl(db, "trysample")

# histogram of skipping?
switch_track <- year_month <- tbl(db,sql("select *
from (select f.[ID_USER], f.[UTS], (ifnull(f2.UTS,0)-f.UTS) as diff, f.row_num, f.TRACK_DURATION
from trysample f, trysample f2
where f2.row_num=(f.row_num+1)) G
where G.diff < 60 and G.[diff] > 0 and G.diff/G.[TRACK_DURATION] < 0.0005     
           "))                          # here the time interval is limited to 60, diff/track_duration ratio 0.0005
switchtra <- collect(switch_track)
hist(switchtra$diff)

# where are tags and genres?
# if scrobbling only records the track when more than half of it is listened, why are there skips/switches in 10 seconds?

# add percentage: how to transform track_duration to seconds?
#-----------------------------