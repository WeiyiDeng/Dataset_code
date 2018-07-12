create table dt7_member_plus_friend_names_fix_1st_week_artist(USERS char, ARTIST char, WEEK_ID integer);
insert into dt7_member_plus_friend_names_fix_1st_week_artist

select USERS, ARTIST, min(WEEK_ID) as WEEK_ID 
from dt7_member_plus_friend_names_fix_weeks_artist
group by USERS, ARTIST