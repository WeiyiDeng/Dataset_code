SELECT * from (select ARTIST, min(WEEK_ID) from mytemp_4948_2
group by ARTIST)
WHERE ARTIST in (select ARTIST from FID_4948_8849_verify)