create table test_fm(USERS char, NEW_UID char, TRACK_ID char, NEW_TID char, listens integer);
insert into test_fm

select dt7_member_plus_friend_names_fix_sum.USERS as USERS, test_flist.new_id as NEW_UID, dt7_member_plus_friend_names_fix_sum.TRACK_ID, test_ftrack.new_id as NEW_TID, listens 
from dt7_member_plus_friend_names_fix_sum, test_flist, test_ftrack
where dt7_member_plus_friend_names_fix_sum.USERS = test_flist.USERS and dt7_member_plus_friend_names_fix_sum.TRACK_ID = test_ftrack.TRACK_ID