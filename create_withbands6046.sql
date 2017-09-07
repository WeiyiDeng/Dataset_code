create table withbands6046(USER char, WEEK_ID integer, BAND_ID integer, COUNT_mod integer);
insert into withbands6046

select USER, WEEK_ID, BAND_ID, COUNT_mod
from dt4_band_id6046, dt7, dba.weeky
where dt4_band_id6046.TRACK_ID = dt7.TRACK_ID and dba.weeky.FROM_UTS = dt7.FROM_UTS;

-- withbands6046 equivalent to withbandweeks in sever trial.txt