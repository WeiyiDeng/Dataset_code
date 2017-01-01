--select count(*) from listen_trends_left_join

--select count(*) from listen_trend_lab

--select count(*) from indlistens_copy

/*
create table indlistens_copy(bands_num_vec integer, weeks_vec integer, listen integer, adopt integer);
insert into indlistens_copy(bands_num_vec, weeks_vec, listen, adopt)
select * from indlistens
*/

create table listen_trends_left_join_big(listen integer, adopt integer, trend_ori numeric, trend_cat3 numeric, trend_cat35 numeric, trend_lab numeric, bands_num_vec integer, weeks_vec integer);
insert into listen_trends_left_join_big(listen, adopt, trend_ori, trend_cat3, trend_cat35, trend_lab, bands_num_vec, weeks_vec)

--SELECT count(*)
--FROM(
select listen, adopt, gtrends_ori.gtrends as trend_ori, gtrends_cat3_mod.gtrends as trend_cat3, gtrends_cat35.gtrends as trend_cat35, gtrends_lab.gtrends as trend_lab, totallistenb.BAND_ID, totallistenb.WEEK_ID
from totallistenb
left join gtrends_ori 
on totallistenb.BAND_ID = gtrends_ori.bands_num_vec and totallistenb.WEEK_ID = gtrends_ori.weeks_vec
left join gtrends_cat3_mod 
on totallistenb.BAND_ID = gtrends_cat3_mod.bands_num_vec and totallistenb.WEEK_ID = gtrends_cat3_mod.weeks_vec
left join gtrends_cat35 
on totallistenb.BAND_ID = gtrends_cat35.bands_num_vec and totallistenb.WEEK_ID = gtrends_cat35.weeks_vec
left join gtrends_lab 
on totallistenb.BAND_ID = gtrends_lab.bands_num_vec and totallistenb.WEEK_ID = gtrends_lab.weeks_vec
--where gtrends_lab.gtrends is null
--)
;

update listen_trends_left_join_big set trend_ori = 0 where trend_ori is null;
update listen_trends_left_join_big set trend_cat3 = 0 where trend_cat3 is null;
update listen_trends_left_join_big set trend_cat35 = 0 where trend_cat35 is null;
update listen_trends_left_join_big set trend_lab = 0 where trend_lab is null;