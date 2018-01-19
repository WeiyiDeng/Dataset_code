create table cutbands_min_UTS(ARTIST text, min_UTS integer);
insert into cutbands_min_UTS

select ARTIST, min(FROM_UTS) as min_UTS
from cutbands
group by ARTIST