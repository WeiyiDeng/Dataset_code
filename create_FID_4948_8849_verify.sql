-- note that shared adoptions only includes half of all listen periods per user !!!

create table FID_4948_8849_verify(USERS char, WEEK_ID integer, ARTIST char);
insert into FID_4948_8849_verify

SELECT * FROM 
(select * from FID_8849_temp_min
where ARTIST in (select ARTIST from FID_4948_temp_min))
WHERE ARTIST in (select ARTIST from dbaf.newbandlist) 