create table count_bands_num_user(ARTIST text, num_user integer);
insert into count_bands_num_user

SELECT ARTIST, count(distinct USER) as num_user
FROM (select USER, ARTIST
from cutbands
group by USER, ARTIST)
GROUP BY ARTIST