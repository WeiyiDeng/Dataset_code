select count(*)
from (SELECT bands_num_vec, weeks_vec, count(*) FROM
(select BAND_ID, WEEK_ID, listen, adopt, gtrends, bands_num_vec, weeks_vec
from indlistens, gtrends_lab
where WEEK_ID = weeks_vec and BAND_ID = bands_num_vec)
GROUP BY bands_num_vec, weeks_vec)
--select count(*) from indlistens