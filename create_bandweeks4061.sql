create table bandweeks4061(USER text, week_ID integer, COUNT_mod integer, BAND_ID integer);
insert into bandweeks4061

SELECT USER, (WEEK_ID-104) as week_ID, COUNT_mod, BAND_ID
FROM withbands6046
WHERE BAND_ID in (select BAND_ID from dbaf.newbandsNo4061);

--bandweeks4061 equivalent to modelbandweeks in sever trial.txt