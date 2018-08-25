create table ARTIST6046_start_week(NEW_AID integer, SRART_WEEK integer);
insert into ARTIST6046_start_week

select NEW_AID, START_WEEK
from artist_start_week
where NEW_AID in (SELECT NEW_ID FROM artist_new_old_id_6046) 