create table listen_trends_left_join_big4061(listen integer, adopt integer, trend_ori numeric, trend_cat3 numeric, trend_cat35 numeric, trend_lab numeric, bands_num_vec integer, weeks_vec integer);
insert into listen_trends_left_join_big4061(listen, adopt, trend_ori, trend_cat3, trend_cat35, trend_lab, bands_num_vec, weeks_vec)

select * from listen_trends_left_join_big6046
where bands_num_vec in (select BAND_ID from dbaf.newbandsNo4061)