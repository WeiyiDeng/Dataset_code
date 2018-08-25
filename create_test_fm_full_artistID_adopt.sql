create table test_fm_full_artistID_adopt(NEW_UID char, NEW_AID char, WEEK_ID integer);
insert into test_fm_full_artistID_adopt

select NEW_UID, NEW_AID, min(WEEK_ID) as WEEK_ID 
from test_fm_full_artistID_listen
group by NEW_UID, NEW_AID