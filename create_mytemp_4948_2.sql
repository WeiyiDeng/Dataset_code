create table mytemp_4948_2(USERS char, WEEK_ID integer, ARTIST char, COUNT_mod integer);
insert into mytemp_4948_2

select USERS, WEEK_ID, ARTIST, COUNT_mod
from mytemp_4948, dba.dt4, weeky
where mytemp_4948.TRACK_ID = dba.dt4.TRACK_ID and weeky.FROM_UTS = mytemp_4948.FROM_UTS