create table ALL_USERS(USERS char);
insert into ALL_USERS

select USERS from dt7_member_plus_friend_names_fix_sum
union
select USERS from dt7_member_plus_neighbour_names_fix_sum