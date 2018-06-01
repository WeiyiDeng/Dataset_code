create table test_nm_artist_id(NEW_UID char, NEW_AID char, listens integer);
insert into test_nm_artist_id

select NEW_UID, NEW_AID, listens
from test_nm_artist