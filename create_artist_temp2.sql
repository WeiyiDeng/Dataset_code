create table artist_temp2(USERS char, ARTIST char, listens integer);
insert into artist_temp2

select USERS, ARTIST, listens
from dt7_member_plus_friend_names_fix_sum, dba.dt4
where dt7_member_plus_friend_names_fix_sum.TRACK_ID = dba.dt4.TRACK_ID