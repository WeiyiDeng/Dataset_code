create table member_plus_friend_names(USERS char);
insert into member_plus_friend_names

select distinct USER from (select * from dt2
where USER != 'skeleandmole')
union
select distinct FRIEND from (select * from dt2
where USER != 'skeleandmole')