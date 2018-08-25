create table test_nm_full_artistID_listen(NEW_UID char, NEW_AID char, WEEK_ID integer);
insert into test_nm_full_artistID_listen

select dba.test_nlist.new_id as NEW_UID, test_mnfartist.new_id as NEW_AID, WEEK_ID 
from dt7_member_plus_neighbour_names_fix_weeks_artist, dba.test_nlist, test_mnfartist
where dt7_member_plus_neighbour_names_fix_weeks_artist.USERS = dba.test_nlist.USERS and dt7_member_plus_neighbour_names_fix_weeks_artist.ARTIST = test_mnfartist.ARTIST