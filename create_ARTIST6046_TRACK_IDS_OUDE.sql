﻿create table ARTIST6046_TRACK_IDS_OUDE(TRACK_ID char, ARTIST char, BAND_ID char);
insert into ARTIST6046_TRACK_IDS_OUDE

select TRACK_ID,ARTIST6046_TRACK_IDS.ARTIST,BAND_ID
from ARTIST6046_TRACK_IDS, db7.artist_new_old_id_6046
where ARTIST6046_TRACK_IDS.ARTIST = db7.artist_new_old_id_6046.ARTIST