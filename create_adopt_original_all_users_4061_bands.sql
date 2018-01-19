create table adopt_original_all_users_4061_bands(BAND_ID integer, WEEK_ID integer, adopt integer);
insert into adopt_original_all_users_4061_bands(BAND_ID, WEEK_ID, adopt)

SELECT BAND_ID, week as WEEK_ID, count(distinct USER_ID) as adopt 
FROM (select USER_ID, BAND_ID, min(week_ID) as week
from bandweeks4061_original_adopt
group by USER_ID, BAND_ID)
group by BAND_ID, week