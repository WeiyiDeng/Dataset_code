create table all_test_fm_id(NEW_UID char, NEW_TID char, listens integer);
insert into all_test_fm_id

select NEW_UID, NEW_TID, listens
from all_test_fm