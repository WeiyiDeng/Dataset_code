create table dt7_member_plus_friend_names_fix_weeks(USERS char, TRACK_ID char, WEEK_ID integer, COUNTmod integer);
insert into dt7_member_plus_friend_names_fix_weeks

select USERS, TRACK_ID, WEEK_ID, COUNTmod 
from dt7_member_plus_friend_names_fix, dba.weeky
where dt7_member_plus_friend_names_fix.FROM_UTS = dba.weeky.FROM_UTS