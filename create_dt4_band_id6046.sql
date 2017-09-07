create table dt4_band_id6046(TRACK_ID integer, ARTIST char, BAND_ID integer);
insert into dt4_band_id6046

select TRACK_ID, dba.dt4.ARTIST, BAND_ID 
from dba.dt4, dbaf.newbandlist
where dba.dt4.ARTIST=dbaf.newbandlist.ARTIST