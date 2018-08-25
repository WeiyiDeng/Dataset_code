create table nm_fm_artist_temp(NEW_AID integer, START_WEEK integer);
insert into nm_fm_artist_temp

select NEW_AID, START_WEEK
from nm_artist_temp
union
select NEW_AID, START_WEEK
from fm_artist_temp