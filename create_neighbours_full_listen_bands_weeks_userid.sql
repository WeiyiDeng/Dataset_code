create table neighbours_full_listen_bands_weeks_userid(USER_ID integer, BAND_ID integer, WEEK_ID integer, COUNT_mod integer);
insert into neighbours_full_listen_bands_weeks_userid

select USER_ID, BAND_ID, WEEK_ID, count_mod 
from neighbours_full_listen_bands_weeks, neighbourlist_id_union
where neighbours_full_listen_bands_weeks.USER = neighbourlist_id_union.USER