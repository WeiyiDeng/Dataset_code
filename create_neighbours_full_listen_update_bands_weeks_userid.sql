--verify_neighbourlist_id_to_remove
/*
select count(*) from (SELECT sum(COUNT_mod) as num_obs, USER
FROM (select * from dt7
where USER in (select USER from neighbourlist_id_to_remove))
GROUP BY USER) where num_obs < 100
*/
--remove neighbours from neighbourlist_id_to_remove
create table neighbours_full_listen_update_bands_weeks_userid(USER_ID integer, BAND_ID integer, WEEK_ID integer, COUNT_mod integer);
insert into neighbours_full_listen_update_bands_weeks_userid

select * from neighbours_full_listen_bands_weeks_userid
where USER_ID not in (select USER_ID from neighbourlist_id_to_remove)
