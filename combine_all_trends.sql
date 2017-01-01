/*create table listen_trend_ori(BAND_ID integer, WEEK_ID integer, listen integer, adopt integer, gtrends numeric, bands_num_vec integer, weeks_vec integer);

insert into listen_trend_ori(BAND_ID, WEEK_ID, listen, adopt, gtrends, bands_num_vec, weeks_vec)
select BAND_ID, WEEK_ID, listen, adopt, gtrends, bands_num_vec, weeks_vec
from indlistens, gtrends_ori
where WEEK_ID = weeks_vec and BAND_ID = bands_num_vec;
*/

--select count(*) from listen_trend_ori

--select count(*) from indlistens

/*create table listen_trend_cat3(BAND_ID integer, WEEK_ID integer, listen integer, adopt integer, trend_ori numeric, trend_cat3 numeric, bands_num_vec integer, weeks_vec integer);
insert into listen_trend_cat3(BAND_ID, WEEK_ID, listen, adopt, trend_ori, trend_cat3, bands_num_vec, weeks_vec)
select BAND_ID, WEEK_ID, listen, adopt, trend_ori, gtrends_cat3_mod.gtrends as trend_cat3, gtrends_cat3_mod.bands_num_vec, gtrends_cat3_mod.weeks_vec
from listen_trend_ori, gtrends_cat3_mod
where WEEK_ID = gtrends_cat3_mod.weeks_vec and BAND_ID = gtrends_cat3_mod.bands_num_vec;
*/

/*
create table listen_trend_cat35(BAND_ID integer, WEEK_ID integer, listen integer, adopt integer, trend_ori numeric, trend_cat3 numeric, trend_cat35 numeric, bands_num_vec integer, weeks_vec integer);
insert into listen_trend_cat35(BAND_ID, WEEK_ID, listen, adopt, trend_ori, trend_cat3, trend_cat35, bands_num_vec, weeks_vec)
select BAND_ID, WEEK_ID, listen, adopt, trend_ori, trend_cat3, gtrends_cat35.gtrends as trend_cat35, gtrends_cat35.bands_num_vec, gtrends_cat35.weeks_vec
from listen_trend_cat3, gtrends_cat35
where WEEK_ID = gtrends_cat35.weeks_vec and BAND_ID = gtrends_cat35.bands_num_vec;
*/

create table listen_trend_lab(BAND_ID integer, WEEK_ID integer, listen integer, adopt integer, trend_ori numeric, trend_cat3 numeric, trend_cat35 numeric, trend_lab numeric, bands_num_vec integer, weeks_vec integer);
insert into listen_trend_lab(BAND_ID, WEEK_ID, listen, adopt, trend_ori, trend_cat3, trend_cat35, trend_lab, bands_num_vec, weeks_vec)
select BAND_ID, WEEK_ID, listen, adopt, trend_ori, trend_cat3, trend_cat35, gtrends_lab.gtrends as trend_lab, gtrends_lab.bands_num_vec, gtrends_lab.weeks_vec
from listen_trend_cat35, gtrends_lab
where WEEK_ID = gtrends_lab.weeks_vec and BAND_ID = gtrends_lab.bands_num_vec;

--select * from gtrends_lab
--where weeks_vec = 264 and bands_num_vec = 10