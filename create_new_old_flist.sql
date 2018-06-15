create table new_old_flist(OLD_FID char, NEW_FID char);
insert into new_old_flist

select USER_ID as old_id, new_id 
from dbaf.userlist, test_flist
where USER = USERS