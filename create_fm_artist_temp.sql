create table fm_artist_temp(NEW_AID integer, START_WEEK integer);
insert into fm_artist_temp

select NEW_AID, min(WEEK_ID) as START_WEEK
from test_fm_full_artistID_listen
group by NEW_AID