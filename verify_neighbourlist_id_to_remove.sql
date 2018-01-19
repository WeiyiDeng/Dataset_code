select count(*) from (SELECT sum(COUNT_mod) as num_obs, USER
FROM (select * from dt7
where USER in (select USER from neighbourlist_id_to_remove))
GROUP BY USER) where num_obs < 100