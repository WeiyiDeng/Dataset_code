create table neighbours_full_listen_bands(USER char, FROM_UTS integer, BAND_ID integer, COUNT_mod integer);
insert into neighbours_full_listen_bands

select USER, FROM_UTS, BAND_ID, count_mod 
from get_neighbours, dt4_band_id6046
where get_neighbours.TRACK_ID = dt4_band_id6046.TRACK_ID
