create table test_fm_artist(USERS char, NEW_UID char, ARTIST char, NEW_AID char, listens integer);
insert into test_fm_artist

select dt7_member_plus_friend_names_fix_sum_artist.USERS as USERS, test_flist.new_id as NEW_UID, dt7_member_plus_friend_names_fix_sum_artist.ARTIST, test_fartist.new_id as NEW_AID, listens 
from dt7_member_plus_friend_names_fix_sum_artist, test_flist, test_fartist
where dt7_member_plus_friend_names_fix_sum_artist.USERS = test_flist.USERS and dt7_member_plus_friend_names_fix_sum_artist.ARTIST = test_fartist.ARTIST
