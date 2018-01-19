create table bandadoptions_neighbour(USER_ID integer, BAND_ID integer, WEEK_ID integer);
insert into bandadoptions_neighbour

select USER_ID, BAND_ID, min(WEEK_ID) as WEEK_ID
from neighbours_full_listen_update_bands_weeks_userid
group by USER_ID, BAND_ID
order by USER_ID, BAND_ID