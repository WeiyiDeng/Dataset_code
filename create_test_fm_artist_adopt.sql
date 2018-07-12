create table test_fm_artist_adopt(USERS char, NEW_UID char, ARTIST char, NEW_AID char, WEEK_ID integer);
insert into test_fm_artist_adopt

select dt7_member_plus_friend_names_fix_1st_week_artist.USERS as USERS, test_flist.new_id as NEW_UID, dt7_member_plus_friend_names_fix_1st_week_artist.ARTIST, test_fartist.new_id as NEW_AID, WEEK_ID 
from dt7_member_plus_friend_names_fix_1st_week_artist, test_flist, test_fartist
where dt7_member_plus_friend_names_fix_1st_week_artist.USERS = test_flist.USERS and dt7_member_plus_friend_names_fix_1st_week_artist.ARTIST = test_fartist.ARTIST