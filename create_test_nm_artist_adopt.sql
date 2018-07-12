create table test_nm_artist_adopt(USERS char, NEW_UID char, ARTIST char, NEW_AID char, WEEK_ID integer);
insert into test_nm_artist_adopt

select dt7_member_plus_neighbour_names_fix_1st_week_artist.USERS as USERS, test_nlist.new_id as NEW_UID, dt7_member_plus_neighbour_names_fix_1st_week_artist.ARTIST, test_nartist.new_id as NEW_AID, WEEK_ID 
from dt7_member_plus_neighbour_names_fix_1st_week_artist, test_nlist, test_nartist
where dt7_member_plus_neighbour_names_fix_1st_week_artist.USERS = test_nlist.USERS and dt7_member_plus_neighbour_names_fix_1st_week_artist.ARTIST = test_nartist.ARTIST