create table listenbandweeks6046(BAND_ID integer, WEEK_ID integer, listen integer);
insert into listenbandweeks6046

select BAND_ID, (week_ID-104) as WEEK_ID, sum(COUNT_mod) as listen
from withbands6046
group by BAND_ID, week_ID