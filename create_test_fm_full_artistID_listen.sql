create table test_fm_full_artistID_listen(NEW_UID char, NEW_AID char, WEEK_ID integer);
insert into test_fm_full_artistID_listen

select test_flist.new_id as NEW_UID, test_mnfartist.new_id as NEW_AID, WEEK_ID 
from dt7_member_plus_friend_names_fix_weeks_artist, test_flist, test_mnfartist
where dt7_member_plus_friend_names_fix_weeks_artist.USERS = test_flist.USERS and dt7_member_plus_friend_names_fix_weeks_artist.ARTIST = test_mnfartist.ARTIST