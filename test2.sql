--select count(*) from new_friendlist_7623
--select count(*) from bandID_1st_listen       --6971 distinct friends

--select max(WEEK_ID) from bandID_1st_listen

--select USER, ARTIST, count(*) as times_listened
--from filterlis_weekid
--group by USER, ARTIST

create table listen_times (USER_ID integer, BAND_ID integer, times_listened integer);
insert into listen_times

SELECT USER_ID, BAND_ID, times_listened
FROM (select USER, ARTIST, count(*) as times_listened
from filterlis_weekid
group by USER, ARTIST) as Adopt, newbandlist, userlist
WHERE Adopt.ARTIST = newbandlist.ARTIST and Adopt.USER = userlist.USER
ORDER BY USER_ID, BAND_ID


--select * from band_intro_6046
--where BAND_ID = 3871

--select * from user_intro_8320
--where USER = 5397

--create table bandID_1st_listen (BAND_ID integer, WEEK_ID integer);
--insert into bandID_1st_listen

--SELECT BAND_ID, week_ID
--FROM newbandlist, band_1st_listen
--where newbandlist.ARTIST = band_1st_listen.ARTIST

--create table filterlis_weekid (USER text, ARTIST text, WEEK_ID integer, FROM_UTS char);
--insert into filterlis_weekid

--SELECT USER, ARTIST, week_ID, filterlis.FROM_UTS
--FROM filterlis, weeky
--where filterlis.FROM_UTS = weeky.FROM_UTS

--create table user_1st_listen (USER text, WEEK_ID integer);
--insert into user_1st_listen

--select USER, min(Week_ID) as WEEK_ID
--from filterlis_weekid
--group by USER

--select count(distinct BAND_ID) from modelbandweeks

--select count(distinct USER_ID) from bandadoptions_strict_adopt

--select count(distinct USER) from fbandslisn

--select count(*) from fbandslisn

--select count(*) from bandadoptions

--select distinct USER_ID from bandadoptions_strict_adopt

--select count(*) from peak_strict

/*
select USER_ID, mod_adoptions_strict.BAND_ID, mod_adoptions_strict.week_mod, introdate.week_mod as bandintro, peak_strict.week_mod as bandpeak
from mod_adoptions_strict, peak_strict, introdate
where mod_adoptions_strict.BAND_ID = peak_strict.BAND_ID and mod_adoptions_strict.BAND_ID = introdate.BAND_ID
*/

/*
select count(*)
from (SELECT *
FROM (select * from friendlist
where MEMBER in (select distinct USER_ID from bandadoptions_strict_adopt)) as M
WHERE FRIEND in (select distinct USER_ID from bandadoptions_strict_adopt))
