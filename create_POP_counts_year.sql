create table POP_counts_year(count_listens int, BAND_ID char, week_ID char, year_time char);
insert into POP_counts_year

select count_listens, BAND_ID, POP_counts.week_ID, yearw 
from POP_counts, weeky
where POP_counts.week_ID = weeky.week_ID