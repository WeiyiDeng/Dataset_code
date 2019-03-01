select count(distinct USERS)
from (select USERS from temp2 where USERS in (select USER from dbaf.userlist)
union
select FRIEND from temp2 where FRIEND in (select USER from dbaf.userlist))