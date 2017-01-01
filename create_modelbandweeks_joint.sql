create table modelbandweeks_joint(USER char, week_ID integer, COUNTmod integer, BAND_ID integer, WEEK_USER integer, WEEK_BAND integer);
insert into modelbandweeks_joint(USER, week_ID, COUNTmod, BAND_ID, WEEK_USER, WEEK_BAND)

select modelbandweeks.USER, modelbandweeks.week_ID, COUNTmod, modelbandweeks.BAND_ID, WEEK_USER, WEEK_BAND 
from modelbandweeks, user_intro, band_intro
where user_intro.USER = modelbandweeks.USER and band_intro.BAND_ID = modelbandweeks.BAND_ID

--select BAND_ID, sum(listen) as sum_listen
--from listenbandweeks
--group by BAND_ID

/*
create table user_intro(USER char, WEEK_USER integer);
insert into user_intro(USER, WEEK_USER)

select USER, min(week_ID) as week_user
from modelbandweeks
group by USER
*/

/*
create table band_intro(BAND_ID integer, WEEK_BAND integer);
insert into band_intro(BAND_ID, WEEK_BAND)

select BAND_ID, min(week_ID) as week
from modelbandweeks
group by BAND_ID
*/

--select count(*) from user_intro
--select count(distinct BAND_ID) from adopt_all_users_2588
--select count(*) from modelbandweeks
--select sum(adopt) from adopt_all_users_2588
--select sum(listen) from listenbandweeks
--select sum(listen) from totallistenb

--select count(distinct BAND_ID) from modelbandweeks
--select sum(COUNTmod) from modelbandweeks

/*
create table adopt_all_users_2588(BAND_ID integer, WEEK_ID integer, adopt integer);
insert into adopt_all_users_2588(BAND_ID, WEEK_ID, adopt)

SELECT BAND_ID, week as WEEK_ID, count(distinct USER) as adopt 
FROM (select USER, BAND_ID, min(week_ID) as week
from dbas.modelbandweeks
group by USER, BAND_ID)
group by BAND_ID, week
*/

--select count(*) from listen_trends_left_join_big
--select max(weeks_vec) from listen_trends_left_join
/*
SELECT avg(sth)
FROM (select bands_num_vec, count(*) as sth 
from listen_trends_left_join_big
group by bands_num_vec)
*/
--select count(*) from indlistens_copy

/*
create table indlistens_copy(bands_num_vec integer, weeks_vec integer, listen integer, adopt integer);
insert into indlistens_copy(bands_num_vec, weeks_vec, listen, adopt)
select * from indlistens
*/
/*
create table listen_trends_left_join(listen integer, adopt integer, trend_ori numeric, trend_cat3 numeric, trend_cat35 numeric, trend_lab numeric, bands_num_vec integer, weeks_vec integer);
insert into listen_trends_left_join(listen, adopt, trend_ori, trend_cat3, trend_cat35, trend_lab, bands_num_vec, weeks_vec)

--SELECT count(*)
--FROM(
select listen, adopt, gtrends_ori.gtrends as trend_ori, gtrends_cat3_mod.gtrends as trend_cat3, gtrends_cat35.gtrends as trend_cat35, gtrends_lab.gtrends as trend_lab, indlistens_copy.bands_num_vec, indlistens_copy.weeks_vec
from indlistens_copy
left join gtrends_ori 
on indlistens_copy.bands_num_vec = gtrends_ori.bands_num_vec and indlistens_copy.weeks_vec = gtrends_ori.weeks_vec
left join gtrends_cat3_mod 
on indlistens_copy.bands_num_vec = gtrends_cat3_mod.bands_num_vec and indlistens_copy.weeks_vec = gtrends_cat3_mod.weeks_vec
left join gtrends_cat35 
on indlistens_copy.bands_num_vec = gtrends_cat35.bands_num_vec and indlistens_copy.weeks_vec = gtrends_cat35.weeks_vec
left join gtrends_lab 
on indlistens_copy.bands_num_vec = gtrends_lab.bands_num_vec and indlistens_copy.weeks_vec = gtrends_lab.weeks_vec
--where gtrends_lab.gtrends is null
--)
;

update listen_trends_left_join set trend_ori = 0 where trend_ori is null;
update listen_trends_left_join set trend_cat3 = 0 where trend_cat3 is null;
update listen_trends_left_join set trend_cat35 = 0 where trend_cat35 is null;
update listen_trends_left_join set trend_lab = 0 where trend_lab is null;

*/
/*
create table full_weeks_2588(BAND_ID integer, WEEK_ID integer, listen integer);
insert into full_weeks_2588(BAND_ID, WEEK_ID, listen)

select band_names_prep, weeks_prep, listen
from full_weeks_mat
left join listenbandweeks
on BAND_ID = band_names_prep and WEEK_ID = weeks_prep;

update full_weeks_2588 set listen = 0 where listen is null;
*/
/*
create table listen_trends_left_join_full_weeks(listen integer, trend_ori numeric, trend_cat3 numeric, trend_cat35 numeric, trend_lab numeric, bands_num_vec integer, weeks_vec integer);
insert into listen_trends_left_join_full_weeks(listen, trend_ori, trend_cat3, trend_cat35, trend_lab, bands_num_vec, weeks_vec)

--SELECT count(*)
--FROM(
select listen, gtrends_ori.gtrends as trend_ori, gtrends_cat3_mod.gtrends as trend_cat3, gtrends_cat35.gtrends as trend_cat35, gtrends_lab.gtrends as trend_lab, full_weeks_2588.BAND_ID, full_weeks_2588.WEEK_ID
from full_weeks_2588
left join gtrends_ori 
on full_weeks_2588.BAND_ID = gtrends_ori.bands_num_vec and full_weeks_2588.WEEK_ID = gtrends_ori.weeks_vec
left join gtrends_cat3_mod 
on full_weeks_2588.BAND_ID = gtrends_cat3_mod.bands_num_vec and full_weeks_2588.WEEK_ID = gtrends_cat3_mod.weeks_vec
left join gtrends_cat35 
on full_weeks_2588.BAND_ID = gtrends_cat35.bands_num_vec and full_weeks_2588.WEEK_ID = gtrends_cat35.weeks_vec
left join gtrends_lab 
on full_weeks_2588.BAND_ID = gtrends_lab.bands_num_vec and full_weeks_2588.WEEK_ID = gtrends_lab.weeks_vec
--where gtrends_lab.gtrends is null
--)
;


update listen_trends_left_join_full_weeks set trend_ori = 0 where trend_ori is null;
update listen_trends_left_join_full_weeks set trend_cat3 = 0 where trend_cat3 is null;
update listen_trends_left_join_full_weeks set trend_cat35 = 0 where trend_cat35 is null;
update listen_trends_left_join_full_weeks set trend_lab = 0 where trend_lab is null;