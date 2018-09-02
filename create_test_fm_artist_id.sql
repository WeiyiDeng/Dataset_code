create table test_fm_artist_id(NEW_UID char, NEW_AID char, listens integer);
insert into test_fm_artist_id

select NEW_UID, NEW_AID, listens
from test_fm_artist

--w: notice the listens variable here is not computed by me, not directly usable !!