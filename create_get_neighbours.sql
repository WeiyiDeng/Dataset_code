create table get_neighbours(USER char, FROM_UTS integer, TRACK_ID integer, COUNT_mod integer);
insert into get_neighbours

select * from dt7
where USER in (SELECT * from dba.Neighbour_username_list)