create table band_intro_prep2(BAND_ID integer, WEEK_ID integer);
insert into band_intro_prep2

select BAND_ID, WEEK_ID
from band_intro_prep, dbaf.weeky, dt4_band_id6046
where band_intro_prep.FROM_UTS=dbaf.weeky.FROM_UTS and band_intro_prep.TRACK_ID=dt4_band_id6046.TRACK_ID;