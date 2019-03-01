create table dt7_all_users6046(USER char, FROM_UTS integer, TRACK_ID char, COUNT_mod integer, BAND_ID char);
insert into dt7_all_users6046

select dt7_all_users.*, BAND_ID 
from dt7_all_users, dt4_band_id6046
where dt7_all_users.TRACK_ID = dt4_band_id6046.TRACK_ID