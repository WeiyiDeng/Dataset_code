create table mnfartist(ARTIST char);
insert into mnfartist

select distinct(ARTIST) from dt7_member_plus_neighbour_names_fix_weeks_artist
union
select distinct(ARTIST) from dt7_member_plus_friend_names_fix_weeks_artist