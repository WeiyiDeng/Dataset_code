create table ALL_USERS_dt2(MID char, FID char);
insert into ALL_USERS_dt2

SELECT MID, db7.ALL_USERS.rowid as FID FROM (select dt2.*, db7.ALL_USERS.rowid as MID
from dt2, db7.ALL_USERS
where db7.ALL_USERS.USERS = dt2.USER) as B, db7.ALL_USERS
WHERE db7.ALL_USERS.USERS = B.FRIEND