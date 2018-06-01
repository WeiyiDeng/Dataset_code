create table dt7_member_plus_neighbour_names(USERS char, FROM_UTS char, TRACK_ID char, COUNTmod integer);
insert into dt7_member_plus_neighbour_names

select * from dt7
where USER in (select USERS from dba.member_plus_neighbour_names)