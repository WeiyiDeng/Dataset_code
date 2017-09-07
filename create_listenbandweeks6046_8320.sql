create table adoptbandweeks6046_8320(BAND_ID integer, WEEK_ID integer, adopt integer);
insert into adoptbandweeks6046_8320

select BAND_ID, WEEK_adopt as WEEK_ID, count(distinct USER_ID) as adopt
from adoptbandweeks6046_temp8320
group by BAND_ID, WEEK_ID