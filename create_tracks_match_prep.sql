create table tracks_match_prep (TRACK_ID_1 char, BAND_ID_1 char, TRACK_ID_2 char, MATCH double, BAND_ID_2 char);
insert into tracks_match_prep

select * from (SELECT A.*, BAND_ID as BAND_ID_2 FROM (select TRACK_ID_1, BAND_ID as BAND_ID_1, TRACK_ID_2, MATCH 
from dt6, ARTIST6046_TRACK_IDS_OUDE
where TRACK_ID = TRACK_ID_1) as A, ARTIST6046_TRACK_IDS_OUDE
WHERE TRACK_ID = TRACK_ID_2) as B
where BAND_ID_1 = BAND_ID_2