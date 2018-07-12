create table test_nm_artist_id_adopt(NEW_UID char, NEW_AID char, WEEK_ID integer);
insert into test_nm_artist_id_adopt

select NEW_UID, NEW_AID, WEEK_ID
from test_nm_artist_adopt