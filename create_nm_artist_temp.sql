create table nm_artist_temp(NEW_AID integer, START_WEEK integer);
insert into nm_artist_temp

select NEW_AID, min(WEEK_ID) as START_WEEK
from test_nm_full_artistID_listen
group by NEW_AID