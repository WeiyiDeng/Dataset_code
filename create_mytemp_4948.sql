create table mytemp_4948(USERS char, FROM_UTS char, TRACK_ID char, COUNT_mod integer);
insert into mytemp_4948

select * from dt7_member_plus_friend_names_fix
where TRACK_ID in (select distinct TRACK_ID from FID_4948)