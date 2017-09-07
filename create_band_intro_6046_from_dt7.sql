create table band_intro_6046_from_dt7(BAND_ID integer, WEEK_BAND integer);
insert into band_intro_6046_from_dt7

select BAND_ID, min(WEEK_ID) as WEEK_BAND
from band_intro_prep2
group by BAND_ID