create table ARTIST6046_TRACK_IDS(TRACK_ID char, ARTIST char);
insert into ARTIST6046_TRACK_IDS

select TRACK_ID,ARTIST from dba.dt4
where ARTIST in (SELECT ARTIST FROM artist_new_old_id_6046) 