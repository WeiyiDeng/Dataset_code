create table all_test_nm(USERS char, NEW_UID char, TRACK_ID char, NEW_TID char, listens integer);
insert into all_test_nm

select dt7_member_plus_neighbour_names_fix_sum.USERS as USERS, ALL_USERS.rowid as USERS_ID, dt7_member_plus_neighbour_names_fix_sum.TRACK_ID, ALL_TRACK_IDS.rowid as TRACKS_TID, listens 
from dt7_member_plus_neighbour_names_fix_sum, ALL_USERS, ALL_TRACK_IDS
where dt7_member_plus_neighbour_names_fix_sum.USERS = ALL_USERS.USERS and dt7_member_plus_neighbour_names_fix_sum.TRACK_ID = ALL_TRACK_IDS.TRACK_ID