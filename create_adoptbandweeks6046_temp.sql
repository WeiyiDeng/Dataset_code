create table adoptbandweeks6046_temp(USER char, BAND_ID integer, WEEK_adopt integer);
insert into adoptbandweeks6046_temp

select USER, BAND_ID, min(week_ID-104) as WEEK_adopt
from withbands6046
group by USER, BAND_ID