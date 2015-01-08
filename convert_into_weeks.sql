delete from Week;

insert into Week(week1)
SELECT ROUND(UTS/604800 - 1859)
FROM dataset1



