create table ALL_USERS_dt3(MID char, NID char);
insert into ALL_USERS_dt3

SELECT MID, db7.ALL_USERS.rowid as NID FROM (select dt3.*, db7.ALL_USERS.rowid as MID
from dt3, db7.ALL_USERS
where db7.ALL_USERS.USERS = dt3.USER) as B, db7.ALL_USERS
WHERE db7.ALL_USERS.USERS = B.NEIGHBOUR