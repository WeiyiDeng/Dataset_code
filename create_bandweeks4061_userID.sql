create table bandweeks4061_userID(USER_ID integer, week_ID integer, COUNT_mod integer, BAND_ID integer);
insert into bandweeks4061_userID

SELECT USER_ID, week_ID, COUNT_mod, BAND_ID
FROM bandweeks4061, dbaf.userlist
WHERE bandweeks4061.USER = dbaf.userlist.USER;