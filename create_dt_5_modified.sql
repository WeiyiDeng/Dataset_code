create table dt_5_modified(TAG char, COUNTS int);
insert into dt_5_modified

SELECT TAG, sum(wCOUNTS) as COUNTS FROM
(select tags_modified.TAG, wCOUNTS 
from tags_modified, dt_5
where tags_modified.rowid = dt_5.rowid)
GROUP BY TAG
ORDER BY COUNTS desc