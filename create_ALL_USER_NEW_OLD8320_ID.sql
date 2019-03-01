create table ALL_USER_NEW_OLD8320_ID (OLD_USER_ID integer, NEW_USER_ID integer);
insert into ALL_USER_NEW_OLD8320_ID

select USER_ID, USERS_ID 
from userlist, db7.ALL_USERS
where db7.ALL_USERS.USERS = userlist.USER