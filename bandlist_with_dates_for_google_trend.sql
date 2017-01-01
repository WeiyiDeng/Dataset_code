-- in dbaf.db
SELECT ARTIST, date(UTS, 'unixepoch') as start_date FROM
(select ARTIST, min(FROM_UTS) as UTS from filterbands
group by ARTIST)