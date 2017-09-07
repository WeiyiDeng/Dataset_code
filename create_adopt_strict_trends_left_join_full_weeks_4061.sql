create table adopt_strict_trends_left_join_full_weeks_4061(adopt integer, trend_ori numeric, trend_cat3 numeric, trend_cat35 numeric, trend_lab numeric, bands_num_vec integer, weeks_vec integer);
insert into adopt_strict_trends_left_join_full_weeks_4061(adopt, trend_ori, trend_cat3, trend_cat35, trend_lab, bands_num_vec, weeks_vec)

--SELECT count(*)
--FROM(
select adopt, gtrends4061_ori_423.gtrends as trend_ori, gtrends4061_cat3_423.gtrends as trend_cat3, gtrends4061_cat35_423.gtrends as trend_cat35, gtrends4061_lab_423.gtrends as trend_lab, db7.full_weeks_strict_adopt_all_users_4061_bands.BAND_ID, db7.full_weeks_strict_adopt_all_users_4061_bands.WEEK_ID
from db7.full_weeks_strict_adopt_all_users_4061_bands
left join gtrends4061_ori_423 
on db7.full_weeks_strict_adopt_all_users_4061_bands.BAND_ID = gtrends4061_ori_423.bands_num_vec and db7.full_weeks_strict_adopt_all_users_4061_bands.WEEK_ID = gtrends4061_ori_423.weeks_vec
left join gtrends4061_cat3_423
on db7.full_weeks_strict_adopt_all_users_4061_bands.BAND_ID = gtrends4061_cat3_423.bands_num_vec and db7.full_weeks_strict_adopt_all_users_4061_bands.WEEK_ID = gtrends4061_cat3_423.weeks_vec
left join gtrends4061_cat35_423 
on db7.full_weeks_strict_adopt_all_users_4061_bands.BAND_ID = gtrends4061_cat35_423.bands_num_vec and db7.full_weeks_strict_adopt_all_users_4061_bands.WEEK_ID = gtrends4061_cat35_423.weeks_vec
left join gtrends4061_lab_423 
on db7.full_weeks_strict_adopt_all_users_4061_bands.BAND_ID = gtrends4061_lab_423.bands_num_vec and db7.full_weeks_strict_adopt_all_users_4061_bands.WEEK_ID = gtrends4061_lab_423.weeks_vec
--where gtrends_lab.gtrends is null
--)
;

update adopt_strict_trends_left_join_full_weeks_4061 set trend_ori = 0 where trend_ori is null;
update adopt_strict_trends_left_join_full_weeks_4061 set trend_cat3 = 0 where trend_cat3 is null;
update adopt_strict_trends_left_join_full_weeks_4061 set trend_cat35 = 0 where trend_cat35 is null;
update adopt_strict_trends_left_join_full_weeks_4061 set trend_lab = 0 where trend_lab is null;