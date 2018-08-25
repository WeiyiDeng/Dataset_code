create table artist_start_week(NEW_AID integer, START_WEEK integer);
insert into artist_start_week

select NEW_AID, min(START_WEEK) as START_WEEK
from nm_fm_artist_temp
group by NEW_AID