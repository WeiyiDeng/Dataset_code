create table neighbours_full_listen_bands_weeks(USER char, BAND_ID integer, WEEK_ID integer, COUNT_mod integer);
insert into neighbours_full_listen_bands_weeks

select USER, BAND_ID, WEEK_ID, count_mod 
from neighbours_full_listen_bands, dbaf.weeky
where neighbours_full_listen_bands.FROM_UTS = dbaf.weeky.FROM_UTS