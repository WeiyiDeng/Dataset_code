create table user_intro_prep(USER char, FROM_UTS integer);
insert into user_intro_prep

select USER, FROM_UTS
from dt7
where USER in (SELECT USER FROM dbaf.userlist);