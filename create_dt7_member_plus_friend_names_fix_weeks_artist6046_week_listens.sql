create table dt7_member_plus_friend_names_fix_weeks_artist6046_week_listens(NEW_UID char, NEW_AID char, WEEK_ID integer, week_listens integer);
insert into dt7_member_plus_friend_names_fix_weeks_artist6046_week_listens

select NEW_UID, NEW_AID, WEEK_ID, count(*) as week_listens
from dt7_member_plus_friend_names_fix_weeks_artist6046
group by NEW_UID, NEW_AID, WEEK_ID