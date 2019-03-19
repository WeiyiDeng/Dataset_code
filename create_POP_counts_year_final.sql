create table POP_counts_year_final(BAND_ID char, week_ID char, year_time char, full_year_listens int);
insert into POP_counts_year_final

select POP_counts_year.BAND_ID, POP_counts_year.week_ID, POP_counts_year.year_time, POP_counts_year_agg.full_year_listens
from POP_counts_year, POP_counts_year_agg
where POP_counts_year.BAND_ID = POP_counts_year_agg.BAND_ID and POP_counts_year.year_time = POP_counts_year_agg.year_time