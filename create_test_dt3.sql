create table test_dt3(MID char, NID char, match double);
insert into test_dt3

SELECT MID, new_id as NID, match
FROM (select USER, new_id as MID, neighbour, match
from dt3, test_nlist
where dt3.USER = test_nlist.USERS) as M, test_nlist
WHERE M.neighbour = test_nlist.USERS