create table POP_counts(count_users integer, count_listens integer, BAND_ID char, week_ID char);
insert into POP_counts

select count(USERS) as count_users, sum(count_mod) as count_listens, BAND_ID, week_ID
from temp_dt7
group by BAND_ID, week_ID