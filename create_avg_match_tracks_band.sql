create table avg_match_tracks_band(AVG_MATCH double, BAND_ID integer);
insert into avg_match_tracks_band

select avg(MATCH) as AVG_MATCH, BAND_ID_1 as BAND_ID
from tracks_match_prep
group by BAND_ID_1