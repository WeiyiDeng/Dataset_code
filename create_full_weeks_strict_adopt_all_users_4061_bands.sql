create table full_weeks_strict_adopt_all_users_4061_bands(BAND_ID integer, WEEK_ID integer, adopt integer);
insert into full_weeks_strict_adopt_all_users_4061_bands(BAND_ID, WEEK_ID, adopt)

select band_names_prep, weeks_prep, adopt
from dbr.full_weeks_mat4061
left join adopt_strict_all_users_4061_bands
on BAND_ID = band_names_prep and WEEK_ID = weeks_prep;

update full_weeks_strict_adopt_all_users_4061_bands set adopt = 0 where adopt is null;