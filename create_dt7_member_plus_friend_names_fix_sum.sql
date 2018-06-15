create table dt7_member_plus_friend_names_fix_sum(USERS char, TRACK_ID char, listens integer);
insert into dt7_member_plus_friend_names_fix_sum

select USERS, TRACK_ID, sum(COUNTmod) as listens 
from dt7_member_plus_friend_names_fix
group by USERS, TRACK_ID