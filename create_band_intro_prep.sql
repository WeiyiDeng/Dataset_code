create table band_intro_prep(TRACK_ID integer, FROM_UTS integer);
insert into band_intro_prep

select TRACK_ID, FROM_UTS
from dt7
where TRACK_ID in (SELECT TRACK_ID FROM dt4_band_id6046);