create table dt7_member_plus_friend_names_fix_weeks_artist(USERS char, ARTIST char, WEEK_ID integer);
insert into dt7_member_plus_friend_names_fix_weeks_artist

select USERS, ARTIST, WEEK_ID
from dt7_member_plus_friend_names_fix_weeks, dba.dt4
where dt7_member_plus_friend_names_fix_weeks.TRACK_ID = dba.dt4.TRACK_ID