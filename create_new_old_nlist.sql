create table new_old_nlist(OLD_NID char, NEW_NID char);
insert into new_old_nlist

select USER_ID as old_id, new_id 
from neighbourlist_id, dba.test_nlist
where USER = USERS
union
select USER_ID as old_id, new_id 
from dbaf.userlist, dba.test_nlist
where USER = USERS
-- take into account members in new coding as well