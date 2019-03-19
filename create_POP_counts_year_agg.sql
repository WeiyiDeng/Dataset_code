create table POP_counts_year_agg(full_year_listens int, BAND_ID char, year_time char);
insert into POP_counts_year_agg

select sum(count_listens) as full_year_listens, BAND_ID, year_time
from POP_counts_year
group by BAND_ID, year_time