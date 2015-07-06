delete from trysample2;         -- in this trysample2 does not have rowid

insert into trysample2(ID_USER, UTS, ID_TRACK, TRACK_DURATION, row_num, ID_ARTIST, TopBand, LoveBand, weeknum)
SELECT tb_type.ID_USER, tb_type.UTS, ID_TRACK, TRACK_DURATION, tb_type.rowid, ID_ARTIST, TopBand, LoveBand, weekround 
FROM tb_type, Week2
WHERE tb_type.UTS = Week2.UTS and tb_type.ID_USER =Week2.ID_USER
LIMIT 500000




