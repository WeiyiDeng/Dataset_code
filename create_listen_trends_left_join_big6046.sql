create table listen_trends_left_join_big6046(listen integer, adopt integer, trend_ori numeric, trend_cat3 numeric, trend_cat35 numeric, trend_lab numeric, bands_num_vec integer, weeks_vec integer);
insert into listen_trends_left_join_big6046(listen, adopt, trend_ori, trend_cat3, trend_cat35, trend_lab, bands_num_vec, weeks_vec)

--SELECT count(*)
--FROM(
select listen, adopt, gtrends4061_ori_423.gtrends as trend_ori, gtrends4061_cat3_423.gtrends as trend_cat3, gtrends4061_cat35_423.gtrends as trend_cat35, gtrends4061_lab_423.gtrends as trend_lab, db7.totallistenb6046.BAND_ID, db7.totallistenb6046.WEEK_ID
from db7.totallistenb6046
left join gtrends4061_ori_423 
on db7.totallistenb6046.BAND_ID = gtrends4061_ori_423.bands_num_vec and db7.totallistenb6046.WEEK_ID = gtrends4061_ori_423.weeks_vec
left join gtrends4061_cat3_423 
on db7.totallistenb6046.BAND_ID = gtrends4061_cat3_423.bands_num_vec and db7.totallistenb6046.WEEK_ID = gtrends4061_cat3_423.weeks_vec
left join gtrends4061_cat35_423 
on db7.totallistenb6046.BAND_ID = gtrends4061_cat35_423.bands_num_vec and db7.totallistenb6046.WEEK_ID = gtrends4061_cat35_423.weeks_vec
left join gtrends4061_lab_423 
on db7.totallistenb6046.BAND_ID = gtrends4061_lab_423.bands_num_vec and db7.totallistenb6046.WEEK_ID = gtrends4061_lab_423.weeks_vec
--where gtrends_lab.gtrends is null
--)
;

update listen_trends_left_join_big6046 set trend_ori = 0 where trend_ori is null;
update listen_trends_left_join_big6046 set trend_cat3 = 0 where trend_cat3 is null;
update listen_trends_left_join_big6046 set trend_cat35 = 0 where trend_cat35 is null;
update listen_trends_left_join_big6046 set trend_lab = 0 where trend_lab is null;