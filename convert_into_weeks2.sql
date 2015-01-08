delete from Week;

--1124992835 is the smallest value of UTS larger than 0

insert into Week(ID_USER, UTS, weekround)
SELECT dataset1.[ID_USER], dataset1.[UTS], ROUND((dataset1.[UTS] - 1124992835)/604800)     
FROM dataset1





