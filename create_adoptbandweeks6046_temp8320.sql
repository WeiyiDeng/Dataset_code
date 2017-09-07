create table adoptbandweeks6046_temp8320(USER_ID integer, BAND_ID integer, WEEK_adopt integer);
insert into adoptbandweeks6046_temp8320

select USER_ID, BAND_ID, WEEK_adopt
from adoptbandweeks6046_temp, dbaf.userlist
where adoptbandweeks6046_temp.USER = dbaf.userlist.USER