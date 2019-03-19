create table BAND_dt5_broad(BAND_ID char, Broad int);
insert into BAND_dt5_broad

SELECT BAND_ID, sum(Yes) as Broad FROM
(
select BAND_ID, Yes 
from BAND_dt5, tracks_broad_appeal
where tracks_broad_appeal.rowid = BAND_dt5.rowid
)
GROUP BY BAND_ID