create table cutbands(USER text, ARTIST text, FROM_UTS integer);

insert into cutbands
select USER, ARTIST, FROM_UTS
from dt7, dba.dt4
where dt7.TRACK_ID = dba.dt4.TRACK_ID;