create table test_fm_id(NEW_UID char, NEW_TID char, listens integer);
insert into test_fm_id

select NEW_UID, NEW_TID, listens
from test_fm