create table test_nm_artist(USERS char, NEW_UID char, ARTIST char, NEW_AID char, listens integer);
insert into test_nm_artist

select dt7_member_plus_neighbour_names_fix_sum_artist.USERS as USERS, dba.test_nlist.new_id as NEW_UID, dt7_member_plus_neighbour_names_fix_sum_artist.ARTIST, test_nartist.new_id as NEW_AID, listens 
from dt7_member_plus_neighbour_names_fix_sum_artist, dba.test_nlist, test_nartist
where dt7_member_plus_neighbour_names_fix_sum_artist.USERS = dba.test_nlist.USERS and dt7_member_plus_neighbour_names_fix_sum_artist.ARTIST = test_nartist.ARTIST