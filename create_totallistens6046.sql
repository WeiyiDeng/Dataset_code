create table totallistens6046(BAND_ID integer, WEEK_ID integer, listen integer, adopt integer);
insert into totallistens6046

select listenbandweeks6046.BAND_ID, listenbandweeks6046.WEEK_ID, listen, adopt
from listenbandweeks6046, adoptbandweeks6046
where listenbandweeks6046.BAND_ID = adoptbandweeks6046.BAND_ID and listenbandweeks6046.WEEK_ID = adoptbandweeks6046.WEEK_ID;