create table BAND_count_TRACKS(BAND_ID integer, num_tracks integer);
insert into BAND_count_TRACKS

select BAND_ID, count(TRACK_ID) as num_tracks from ARTIST6046_TRACK_IDS_OUDE
group by BAND_ID
order by BAND_ID asc