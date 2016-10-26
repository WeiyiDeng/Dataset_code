delete from Todate;

insert into Todate(date)
SELECT datetime(FROM_UTS, 'unixepoch')
FROM newtable7;

--Note: first create table Todate with char variable date--

drop table if  exists table7date;
create table table7date(TRACK_ID text, USER text, FROM_UTS int, COUNT int, date char);

insert into table7date(TRACK_ID, USER, FROM_UTS, COUNT, date)
SELECT newtable7.[TRACK_ID], newtable7.[USER], newtable7.[FROM_UTS], newtable7.[COUNT], Todate.[date]     
FROM newtable7, Todate
WHERE newtable7.rowID = TOdate.rowID

--finally change user, count and date to %_mod
