create table dt7_all_usersID6046(USER char, FROM_UTS integer, TRACK_ID char, COUNT_mod integer, BAND_ID char, USERS_ID char);
insert into dt7_all_usersID6046

select dt7_all_users6046.*, ALL_USERS.rowid as USERS_ID
from dt7_all_users6046, ALL_USERS
where dt7_all_users6046.USER = ALL_USERS.USERS