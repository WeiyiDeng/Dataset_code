create table adoptbandweeks6046(BAND_ID integer, WEEK_ID integer, adopt integer);
insert into adoptbandweeks6046

select BAND_ID, WEEK_adopt as WEEK_ID, count(distinct USER) as adopt
from adoptbandweeks6046_temp
group by BAND_ID, WEEK_ID