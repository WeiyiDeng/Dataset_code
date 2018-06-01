create table test_nm(USERS char, NEW_UID char, TRACK_ID char, NEW_TID char, listens integer);
insert into test_nm

select dt7_member_plus_neighbour_names_fix_sum.USERS as USERS, dba.test_nlist.new_id as NEW_UID, dt7_member_plus_neighbour_names_fix_sum.TRACK_ID, test_ntrack.new_id as NEW_TID, listens 
from dt7_member_plus_neighbour_names_fix_sum, dba.test_nlist, test_ntrack
where dt7_member_plus_neighbour_names_fix_sum.USERS = dba.test_nlist.USERS and dt7_member_plus_neighbour_names_fix_sum.TRACK_ID = test_ntrack.TRACK_ID