create table artist_new_old_id_6046(BAND_ID integer, ARTIST char, NEW_ID integer);
insert into artist_new_old_id_6046

select BAND_ID, test_mnfartist.ARTIST, NEW_ID
from test_mnfartist, dbaf.newbandlist
where test_mnfartist.ARTIST = dbaf.newbandlist.ARTIST