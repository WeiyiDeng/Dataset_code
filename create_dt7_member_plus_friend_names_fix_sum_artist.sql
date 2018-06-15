create table dt7_member_plus_friend_names_fix_sum_artist(USERS char, ARTIST char, listens integer);
insert into dt7_member_plus_friend_names_fix_sum_artist

select USERS, ARTIST, sum(listens) as listens from artist_temp2
group by USERS, ARTIST