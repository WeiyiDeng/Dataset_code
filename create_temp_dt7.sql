create table temp_dt7(USERS char, COUNT_mod integer, BAND_ID integer, week_ID integer);
insert into temp_dt7

select USER as USERS, COUNTmod, BAND_ID, week_ID
from dt7,weeky,ARTIST6046_TRACK_IDS_OUDE
where weeky.FROM_UTS = dt7.FROM_UTS and ARTIST6046_TRACK_IDS_OUDE.track_ID = dt7.track_ID