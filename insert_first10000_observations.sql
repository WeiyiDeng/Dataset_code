delete from trysample;

insert into trysample(ID_USER, UTS, ID_TRACK, TRACK_DURATION, row_num, ID_ARTIST, TopBand, LoveBand)
SELECT ID_USER, UTS, ID_TRACK, TRACK_DURATION, rowid, ID_ARTIST, TopBand, LoveBand 
FROM tb_type
LIMIT 500000





