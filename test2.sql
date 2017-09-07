--select count(*) from new_friendlist_7623
--select count(*) from bandID_1st_listen       --6971 distinct friends

--select max(WEEK_ID) from bandID_1st_listen

--select USER, ARTIST, count(*) as times_listened
--from filterlis_weekid
--group by USER, ARTIST

--select count(distinct BAND_ID) from totallistenb
--select count(distinct USER) from fbandslisn
--select count(*) from fbandslisn_band_user_id_order

--select BAND_ID, (WEEK_ID -104) as WEEK_ID, count(USER_ID) as listen
--from fbandslisn_band_user_id_order
--group by BAND_ID, WEEK_ID

--select count(distinct BAND_ID) from modelbandweeks => 2588

--select count(*) from dt7

--select * from dt7
--where FROM_UTS not in (SELECT FROM_UTS from dba.weeky)

--select count(*) from listenbandweeks6046

--select count(*) from withbands6046 => 34213134

--select count(distinct USER) from withbands6046 => 25115

--select max(WEEK_ID) from withbands6046 = 527
--select min(WEEK_ID) from withbands6046 = 104

--select min(FROM_UTS) from dt7 => 1108296002
--select max(FROM_UTS) from dt7 => 1426420800

--select * from dbaf.weeky
--where FROM_UTS="1108296002" or FROM_UTS="1426420800" => 1 & 527

/*
create table debug(USER char, FROM_UTS integer, TRACK_ID integer, COUNT_mod integer);
insert into debug

select * from dt7
where FROM_UTS < 1170590400
*/

--select * from debug
--where TRACK_ID in (SELECT TRACK_ID from dt4_band_id6046) => null

--select count(distinct BAND_ID) from bandadoptions => 6046
--select count(distinct USER_ID) from bandadoptions => 8320

select count(distinct BAND_ID) from adopt_strict_all_users_4061_bands

/*
create table full_weeks_strict_adopt_all_users_2588(BAND_ID integer, WEEK_ID integer, adopt integer);
insert into full_weeks_strict_adopt_all_users_2588(BAND_ID, WEEK_ID, adopt)

select band_names_prep, weeks_prep, adopt
from full_weeks_mat
left join adopt_strict_all_users_2588
on BAND_ID = band_names_prep and WEEK_ID = weeks_prep;

update full_weeks_strict_adopt_all_users_2588 set adopt = 0 where adopt is null;

*/

--select count(distinct BAND_ID) from bandadoptions

--select count(*) from newbandlist

--select rowid from small_bands_names4061

--select count(*) from gtrends_cat3_mod
--where gtrends<0

/*
create table small_bands_names4061 (BAND_ID integer, ARTIST char);
insert into small_bands_names4061

select newbandsNo4061.BAND_ID, ARTIST
from newbandlist, newbandsNo4061
where newbandlist.BAND_ID = newbandsNo4061.BAND_ID
*/
/*
create table listen_times (USER_ID integer, BAND_ID integer, times_listened integer);
insert into listen_times

SELECT USER_ID, BAND_ID, times_listened
FROM (select USER, ARTIST, count(*) as times_listened
from filterlis_weekid
group by USER, ARTIST) as Adopt, newbandlist, userlist
WHERE Adopt.ARTIST = newbandlist.ARTIST and Adopt.USER = userlist.USER
ORDER BY USER_ID, BAND_ID
*/

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
