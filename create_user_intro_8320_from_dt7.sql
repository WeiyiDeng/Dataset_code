create table user_intro_8320_from_dt7(USER_ID integer, WEEK_USER integer);
insert into user_intro_8320_from_dt7

select USER_ID, WEEK_ID as WEEK_USER
from user_intro_prep2, dbaf.weeky, dbaf.userlist
where user_intro_prep2.MIN_FROM_UTS=dbaf.weeky.FROM_UTS and user_intro_prep2.USER=dbaf.userlist.USER;