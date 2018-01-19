--ids of neighbours with less than 100 total listens ready to be removed
create table neighbourlist_id_to_remove(total_listens integer, USER text, USER_ID integer);
insert into neighbourlist_id_to_remove

select total_listens, neighbourlist_id.USER, USER_ID
from (SELECT * FROM
(select sum(COUNT_mod) as total_listens, USER from get_neighbours
group by USER)
WHERE total_listens < 100) as remove_neighbours, neighbourlist_id
where remove_neighbours.USER = neighbourlist_id.USER