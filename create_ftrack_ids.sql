create table ftrack_ids(TRACK_ID char);
insert into ftrack_ids

select distinct TRACK_ID from dt7_member_plus_friend_names_fix_sum
