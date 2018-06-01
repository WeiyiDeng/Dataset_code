create table listen_neighbours (USER_ID integer, BAND_ID integer, times_listened integer);
insert into listen_neighbours

SELECT USER_ID, BAND_ID, sum(COUNT_mod) as times_listened
FROM neighbours_full_listen_update_bands_weeks_userid
GROUP BY USER_ID, BAND_ID
ORDER BY USER_ID, BAND_ID