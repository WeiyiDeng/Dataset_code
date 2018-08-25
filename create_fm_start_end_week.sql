create table fm_start_end_week(NEW_UID integer, START_WEEK integer, END_WEEK integer);
insert into fm_start_end_week

select NEW_UID, min(WEEK_ID) as START_WEEK, max(WEEK_ID) as END_WEEK 
from test_fm_full_artistID_listen
group by NEW_UID