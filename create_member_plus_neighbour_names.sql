create table member_plus_neighbour_names(USERS char);
insert into member_plus_neighbour_names

select distinct USER from dt3
union
select distinct neighbour from dt3