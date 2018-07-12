create table FID_8849_temp_min(USERS char, WEEK_ID integer, ARTIST char);
insert into FID_8849_temp_min

select USERS, min(WEEK_ID), ARTIST
from FID_8849_temp
group by ARTIST