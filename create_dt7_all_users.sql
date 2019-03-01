create table dt7_all_users(USER char, FROM_UTS integer, TRACK_ID char, COUNT_mod integer);
insert into dt7_all_users

select * from dt7
where USER in (select USERS from ALL_USERS)