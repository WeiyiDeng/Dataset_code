create table dt7_all_usersID6046_WEEKID(USERS_ID char, BAND_ID char, WEEK_ID integer);
insert into dt7_all_usersID6046_WEEKID

select USERS_ID, BAND_ID, dbaf.weeky.WEEK_ID
from dt7_all_usersID6046, dbaf.weeky
where dt7_all_usersID6046.FROM_UTS = dbaf.weeky.FROM_UTS