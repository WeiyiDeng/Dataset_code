create table FID_4948_temp(USERS char, WEEK_ID integer, ARTIST char, COUNT_mod integer);
insert into FID_4948_temp

select USERS, WEEK_ID, ARTIST, COUNT_mod
from FID_4948, dba.dt4, weeky
where FID_4948.TRACK_ID = dba.dt4.TRACK_ID and weeky.FROM_UTS = FID_4948.FROM_UTS