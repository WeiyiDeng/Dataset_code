create table test_dt2(MID char, FID char);
insert into test_dt2

SELECT MID, new_id as FID
FROM (select USER, new_id as MID, friend
from dt2, db7.test_flist
where dt2.USER = db7.test_flist.USERS) as M, test_flist
WHERE M.friend = test_flist.USERS