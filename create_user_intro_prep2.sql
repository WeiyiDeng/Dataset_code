create table user_intro_prep2(USER char, MIN_FROM_UTS integer);
insert into user_intro_prep2(USER, MIN_FROM_UTS)

select USER, min(FROM_UTS) as MIN_FROM_UTS
from user_intro_prep
group by USER