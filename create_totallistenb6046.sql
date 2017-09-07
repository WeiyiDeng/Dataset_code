create table totallistenb6046(BAND_ID integer, WEEK_ID integer, listen integer, adopt integer);
insert into totallistenb6046

select BAND_ID, WEEK_ID, listen, adopt
from listenbandweeks6046
left outer join adoptbandweeks6046 using (BAND_ID, WEEK_ID);

update totallistenb6046 set adopt = 0 where adopt is null;